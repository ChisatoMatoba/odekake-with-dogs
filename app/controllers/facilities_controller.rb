class FacilitiesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :set_facility, only: %i[edit show update destroy]
  before_action :move_to_index, except: %i[index show]

  def index
    @facilities = Facility.includes(:user).order('created_at DESC')

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
      redirect_to new_facility_post_path
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
      redirect_to facilities_path(@facility.id)
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

  def move_to_index
    return if user_signed_in?

    redirect_to action: :index
  end

  def facility_params
    params.require(:facility).permit(:prefecture_id, :place_name, :category_id, condition_ids: []).merge(user_id: current_user.id)
  end

  def set_facility
    @facility = Facility.find(params[:id])
  end
end
