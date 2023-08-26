class DogsController < ApplicationController
  def new
    @dog = Dog.new
  end

  def create
    @dog = Dog.new(dog_params)
    if @dog.save
      redirect_to "/users/#{current_user.id}"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def dog_params
    birthday_params = params[:dog_birthday]
    birthday = Date.new(birthday_params["dog_birthday(1i)"].to_i, birthday_params["dog_birthday(2i)"].to_i, birthday_params["dog_birthday(3i)"].to_i)

    params.require(:dog).permit(:dog_name, :breed_id, :gender_id, :image).merge(user_id: current_user.id, dog_birthday: birthday)
  end
end
