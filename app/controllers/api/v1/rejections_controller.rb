class Api::V1::RejectionsController < ApplicationController
  def index
    render json: cities, status: 200
  end

  private

  def rejection_params
    params.permit(:city_id)
  end

  def cities
    City.where(id: city_ids)
  end

  def city_ids
    current_user.rejections.pluck(:city_id)
  end

  def city
    @city ||= City.find_by_id(rejection_params[:city_id])
  end
end
