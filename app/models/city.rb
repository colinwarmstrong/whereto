class City < ApplicationRecord
  validates_presence_of :rank, :name, :state, :growth, :population, :latitude, :longitude

  has_many :favorites
  has_many :rejections
end
