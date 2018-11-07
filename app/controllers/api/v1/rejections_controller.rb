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
    City.find_by_sql(
      "SELECT cities.* FROM cities
      JOIN rejections
      ON rejections.city_id = cities.id
      JOIN users
      ON users.id = rejections.user_id
      WHERE users.id = #{current_user.id}
      ORDER BY rejections.created_at DESC")
  end

  def city
    @city ||= City.find_by_id(rejection_params[:city_id])
  end
end
