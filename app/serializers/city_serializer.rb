class CitySerializer < ActiveModel::Serializer
  attributes :id, :name, :state, :rank, :growth, :population, :latitude, :longitude, :favorite, :rejection

  def growth
    number_to_percentage(object.growth, 1)
  end

  def favorite
    if current_user && Favorite.where(user_id: current_user.id).find_by_city_id(object.id)
      true
    else
      false
    end
  end

  def rejection
    if current_user && Rejection.where(user_id: current_user.id).find_by_city_id(object.id)
      true
    else
      false
    end
  end

  def current_user
    @current_user ||= User.find_by_email('colinwarmstrong@gmail.com')
  end

  private

  def number_to_percentage(number, precision)
    (number.to_f / 10.to_f).round(precision)
  end
end
