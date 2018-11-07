class Api::V1::RejectionsController < ApplicationController
  def index
    render json: cities, status: 200
  end

  def create
    if current_user && city
      current_user.rejections.create(city_id: city.id)
      render json: city, status: 200
    else
      render json: {message: 'Invalid request.'}, status: 404
    end
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
