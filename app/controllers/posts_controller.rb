class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :show, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

  def index
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

  def move_to_index
    return if user_signed_in?

    redirect_to action: :index
  end

  def post_params
    params.require(:post).permit(:prefecture_id, :place_name, :category_id, :people_num, :dogs_num, :rating_id, :review, :image, condition_ids: []).merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
