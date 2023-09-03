class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @age = @user.age_group
    @dog = Dog.new
    @dogs = @user.dogs.includes(:user)
    @post = @user.posts.includes(:user)
  end
end
