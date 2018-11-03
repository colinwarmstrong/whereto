class City < ApplicationRecord
  validates_presence_of :rank, :name, :state, :growth, :population, :latitude, :longitude
end
