class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_facility, except: %i[index]
  before_action :set_post, only: %i[edit update destroy]

  def index
    @facilities = Facility.includes(:post).order(:prefecture_id)
    @posts = Post.includes(:user, :facility, images_attachments: :blob).order(created_at: :DESC)

    @areas = {}
    # 投稿を地域ごとにグループ化する
    @posts.each do |post|
      area = post.facility.area_group
      @areas[area] ||= []
      @areas[area] << post
    end
  end

  def new
    @post = @facility.posts.build
  end

  def create
    @post = @facility.posts.build(post_params)

    # 空欄でないタグフォームのタグ名を配列に
    tag_names = post_params[:tags_attributes].map { |tag_attr| tag_attr[:name].strip }.reject(&:empty?)
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
    tag_names = post_params[:tags_attributes].values.map { |tag_attr| tag_attr[:name].strip }.reject(&:empty?)

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
end
