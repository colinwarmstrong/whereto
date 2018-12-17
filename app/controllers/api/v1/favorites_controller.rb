class Api::V1::FavoritesController < ApplicationController
  def index
    render json: cities, status: 200
  end

  def create
    if current_user && city
      current_user.favorites.create(city_id: city.id)
      render json: city, status: 200
    else
      render json: { message: 'Invalid request.' }, status: 404
    end
  end

  private

  def favorite_params
    params.permit(:city_id)
  end

  def cities
    City.find_by_sql(
      "SELECT cities.*
       FROM cities
       JOIN favorites
       ON favorites.city_id = cities.id
       JOIN users
       ON users.id = favorites.user_id
       WHERE users.id = #{current_user.id}
       ORDER BY favorites.created_at DESC"
    )
  end

  def city
    @city ||= City.find_by_id(favorite_params[:city_id])
  end
end
