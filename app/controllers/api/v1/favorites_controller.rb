class Api::V1::FavoritesController < ApplicationController
  def index
    render json: cities, status: 200
  end

  private

  def cities
    City.where(id: city_ids)
  end

  def city_ids
    current_user.favorites.pluck(:city_id)
  end
end
