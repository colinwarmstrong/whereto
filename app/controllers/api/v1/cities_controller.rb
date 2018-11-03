class Api::V1::CitiesController < ApplicationController
  def index
    render json: City.order(rank: :asc)
  end

  def show
    if city
      render json: city
    else
      render json: {message: "Could not find a city with id #{params[:id]}"}, status: 404
    end
  end

  private

  def city
    @city ||= City.find_by_id(params[:id])
  end
end
