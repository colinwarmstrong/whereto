class Api::V1::FavoritesController < ApplicationController
  def index
    render json: cities, status: 200
  end

  def create
    city = City.find(favorite_params[:city_id])
    if city
      favorite = current_user.favorites.create(city_id: city.id)
      render json: city, status: 200
    else
      render json: {message: 'Invalid city id.'}, status: 404
    end
  end

  private

  def favorite_params
    params.permit(:city_id)
  end

  def cities
    City.where(id: city_ids)
  end

  def city_ids
    current_user.favorites.pluck(:city_id)
  end
end
