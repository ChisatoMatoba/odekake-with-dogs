class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
    @posts = Post.includes(:user).order('created_at DESC')

    @areas = {}
    # 投稿を地域ごとにグループ化する
    @posts.each do |post|
      area = post.area_group
      @areas[area] ||= []
      @areas[area] << post
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.includes(:user)
  end

  def edit
    return if user_signed_in? && current_user.id == @post.user_id

    redirect_to root_path
  end

  def update
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      Rails.logger.debug @post.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = Post.find(params[:id])
    if user_signed_in? && current_user.id == @post.user_id
      post.destroy
      redirect_to root_path
    end
  end

  def move_to_index
    return if user_signed_in?

    redirect_to action: :index
  end

  def post_params
    params.require(:post).permit(:prefecture_id, :place_name, :category_id, :people_num, :dogs_num, :rating_id, :review, condition_ids: [], images: []).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
