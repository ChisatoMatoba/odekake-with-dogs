class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @age = @user.age_group
  end
end
