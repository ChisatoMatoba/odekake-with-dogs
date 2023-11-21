class FacilitiesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_facility, only: %i[edit show update destroy]

  def index
    @facilities = Facility.includes(:user).order(created_at: :desc)

    @areas = {}
    # 投稿を地域ごとにグループ化する
    @facilities.each do |facility|
      area = facility.area_group
      @areas[area] ||= []
      @areas[area] << facility
    end
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
    return if user_signed_in? && current_user.id == @facility.user_id

    redirect_to root_path
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
    facility = Facility.find(params[:id])
    return unless user_signed_in? && current_user.id == @facility.user_id

    facility.destroy
    redirect_to root_path
  end

  private

  def facility_params
    params.require(:facility).permit(:prefecture_id, :place_name, :category_id, condition_ids: []).merge(user_id: current_user.id)
  end

  def set_facility
    @facility = Facility.find(params[:id])
  end
end