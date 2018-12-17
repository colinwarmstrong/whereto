class ApplicationController < ActionController::API
  def current_user
    @current_user ||= User.find_by_email('colinwarmstrong@gmail.com')
  end
end
