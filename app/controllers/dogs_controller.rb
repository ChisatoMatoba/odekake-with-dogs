class DogsController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index

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

  def move_to_index
    return if user_signed_in?

    redirect_to action: :index
  end

  def dog_params
    birthday_params = params[:dog_birthday]

    # 年、月、日の各フィールドが "0" もしくは "---" の場合は無効な日付として扱う
    if birthday_params["dog_birthday(1i)"].to_i == 0 || birthday_params["dog_birthday(2i)"].to_i == 0 || birthday_params["dog_birthday(3i)"].to_i == 0
      # バリデーション
      flash[:error] = "日付を正しく入力してください"
      return
    end

    birthday = Date.new(birthday_params["dog_birthday(1i)"].to_i, birthday_params["dog_birthday(2i)"].to_i, birthday_params["dog_birthday(3i)"].to_i)

    params.require(:dog).permit(:dog_name, :breed_id, :gender_id, :image).merge(user_id: current_user.id, dog_birthday: birthday)
  end
end
