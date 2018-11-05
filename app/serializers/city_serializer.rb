class CitySerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :rank, :growth, :population, :latitude, :longitude

  def growth
    number_to_percentage(object.growth, 1)
  end

  private

  def number_to_percentage(number, precision)
    (number.to_f / 10.to_f).round(precision)
  end
end
