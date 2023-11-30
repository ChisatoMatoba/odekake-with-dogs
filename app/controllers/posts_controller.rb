class PostsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_facility, except: %i[index]
  before_action :set_post, only: %i[edit show update destroy]

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
    if @post.save
      (1..5).each do |i|
        tag_name = params[:post]["tag_#{i}"].strip
        unless tag_name.empty?
          tag = Tag.find_or_create_by(name: tag_name)
          @post.tags << tag unless @post.tags.include?(tag)
        end
      end
      # 登録できたらその投稿の詳細画面へ
      redirect_to facility_post_path(@facility, @post), notice: '投稿が成功しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    redirect_to root_path unless current_user.id == @post.user_id
  end

  def update
    if @post.update(post_params)
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
    params.require(:post).permit(:people_num, :dogs_num, :rating_id, :review, images: [], tags_attributes: %i[id name])
          .merge(user_id: current_user.id, facility_id: params[:facility_id])
  end

  def set_post
    @post = @facility.posts.includes(images_attachments: :blob).find_by(id: params[:id])
  end

  def set_facility
    @facility = Facility.find(params[:facility_id])
  end
end
