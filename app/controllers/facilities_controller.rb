class FacilitiesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_facility, only: %i[edit show update destroy]

  def index
    @search_results = Facility.where('place_name LIKE ?', "%#{params[:search]}%").group_by(&:prefecture_id)

    @prefectures = Prefecture.order(:id)
    @facilities = Facility.order(:prefecture_id)
    @facilities_groupby_pref = @facilities.all.group_by(&:prefecture_id)
  end

  def new
    @facility = Facility.new
  end

  def create
    @facility = Facility.new(facility_params)
    if @facility.save
      # 登録できたらその施設の詳細画面へ
      redirect_to facility_path(@facility)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit
    redirect_to root_path unless current_user.id == @facility.user_id
  end

  def update
    if @facility.update(facility_params)
      redirect_to facility_path(@facility)
    else
      Rails.logger.debug @facility.errors.full_messages
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless current_user.id == @facility.user_id

    @facility.destroy
    redirect_to root_path
  end

  private

  def facility_params
    params.require(:facility).permit(:prefecture_id, :place_name, :category_id, condition_ids: []).merge(user_id: current_user.id)
  end

  def set_facility
    @facility = Facility.includes(:user, posts: [:user, { images_attachments: :blob }]).find_by(id: params[:id])
  end
end
