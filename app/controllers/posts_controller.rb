class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_facility, except: %i[index]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @facilities = Facility.includes(:post).order(:prefecture_id)
    @q = Post.ransack(params[:q]) # Ransackの検索オブジェクトを初期化
    initial_query = @q.result.includes(:user, :facility, images_attachments: :blob).order(created_at: :DESC) # 検索結果を取得

    @search_conditions = {}
    # 地域・都道府県での絞り込み
    narrowed_query = location_narrowdown(initial_query)
    # 施設のカテゴリーでの絞り込み
    narrowed_query = facility_narrowdown(narrowed_query)
    # 施設条件で絞り込み（複数選択のOR）
    narrowed_query = facility_conditions_narrowdown(narrowed_query)

    # 重複を排除し、結果を取得
    @posts = narrowed_query.includes(:user, :facility, images_attachments: :blob).distinct.order(created_at: :DESC)
  end

  def new
    @post = @facility.posts.build
  end

  def create
    @post = @facility.posts.build(post_params)

    # 空欄でないタグフォームのタグ名を配列に
    tag_names = post_params[:tags_attributes].to_h.map { |_, tag_attr| tag_attr[:name].to_s.strip }.reject(&:empty?)

    # @post.tagsに保存
    save_tags(tag_names)

    if @post.save
      # 登録できたらその投稿の詳細画面へ
      redirect_to facility_post_path(@facility, @post), notice: '投稿が成功しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = @facility.posts.includes(images_attachments: :blob).find_by(id: params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    redirect_to root_path unless current_user.id == @post.user_id
  end

  def update
    # 空欄でないタグフォームのタグ名を配列に
    tag_names = post_params[:tags_attributes].to_h.map { |_, tag_attr| tag_attr[:name].to_s.strip }.reject(&:empty?)

    # @post.tagsに保存
    save_tags(tag_names)

    # 既存のタグの属性を準備。既存のタグは削除したくないので、
    # '_destroy' の値を '0' に明示して設定、タグが削除されないようにする
    tags_attributes = @post.tags.map do |tag|
      { id: tag.id, name: tag.name, _destroy: '0' }
    end

    # 更新したいタグの属性を含めて、@post を更新
    if @post.update(post_params.merge(tags_attributes: tags_attributes))
      redirect_to facility_post_path(@facility, @post)
    else
      Rails.logger.debug @post.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless current_user.id == @post.user_id

    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    # tags_attributes: update時は[id]と[_delete]が必要
    params.require(:post).permit(:people_num, :dogs_num, :rating_id, :review, images: [], tags_attributes: %i[id name _destroy])
          .merge(user_id: current_user.id, facility_id: params[:facility_id])
  end

  def set_post
    @post = @facility.posts.find_by(id: params[:id])
  end

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end

  # すでに存在するタグはfind、ないタグはcreateして@post.tagsに保存
  def save_tags(tag_names)
    @post.tags.clear
    tag_names.each do |tag_name|
      tag = Tag.find_or_create_by(name: tag_name)
      @post.tags << tag unless @post.tags.include?(tag)
    end
  end

  # 地域・都道府県が選択された場合の絞り込み処理
  def location_narrowdown(query)
    return query unless params[:q] && params[:q][:location].present?

    location = params[:q][:location]

    narrowed_query = query.joins(:facility).where(facilities: { prefecture_id: location.split(',') })
    # カンマ区切りがある場合は地域とみなして、検索結果を設定する
    @search_conditions['地域'] =
      if location.include?(',')
        Prefecture.find_by(id: location.split(',').first.to_i)&.area&.name
      else
        Prefecture.find_by(id: location)&.name
      end

    # 更新されたクエリを返す
    narrowed_query
  end

  # 施設のカテゴリーでの絞り込み処理
  def facility_narrowdown(query)
    return query unless params[:q] && params[:q][:facility_category_id_eq].present?

    narrowed_query = query.joins(:facility).where(facilities: { category_id: params[:q][:facility_category_id_eq] })

    @posts = @posts.joins(:facility).where(facilities: { category_id: params[:q][:facility_category_id_eq] })
    @search_conditions['施設のカテゴリー'] = Category.find_by(id: params[:q][:facility_category_id_eq])&.name

    # 更新されたクエリを返す
    narrowed_query
  end

  # 施設条件での絞り込み（複数選択のOR）
  def facility_conditions_narrowdown(query)
    return query unless params[:q] && params[:q][:facility_conditions_id_in].present?

    # 空文字列を除外した条件のidを取得
    selected_condition_ids = params[:q][:facility_conditions_id_in].reject(&:blank?).map(&:to_i)

    # 選択されたidに基づく施設の検索
    narrowed_query = query.joins(facility: { facility_conditions: :condition }).where(conditions: { id: selected_condition_ids })
    # 検索条件の保存
    @search_conditions['施設の条件'] = Condition.where(id: selected_condition_ids).pluck(:category).join(', ')

    # 更新されたクエリを返す
    narrowed_query
  end
end
