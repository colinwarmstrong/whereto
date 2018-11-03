class Api::V1::CitiesController < ApplicationController
  def index
    render json: City.order(rank: :asc)
  end
end
