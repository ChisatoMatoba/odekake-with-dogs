class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @age = @user.age_group
    @dog = Dog.new
    @dogs = @user.dogs
    @posts = @user.posts.includes(:facility, images_attachments: :blob)
  end
end
