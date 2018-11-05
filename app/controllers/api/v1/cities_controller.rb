class Api::V1::CitiesController < ApplicationController
  def index
    if city_params[:state]
      render json: City.where(state: city_params[:state]).order(rank: :asc)
    elsif city_params[:sort] == 'population'
      render json: City.order(population: :desc)
    elsif city_params[:sort] == 'alphabetical'
      render json: City.order(name: :asc)
    else
      render json: City.order(rank: :asc)
    end
  end

  def show
    if city
      render json: city
    else
      render json: {message: "Could not find a city with id #{city_params[:id]}"}, status: 404
    end
  end

  private

  def city_params
    params.permit(:id, :state, :sort)
  end

  def city
    @city ||= City.find_by_id(city_params[:id])
  end
end
