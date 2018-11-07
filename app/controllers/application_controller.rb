class ApplicationController < ActionController::API
  serialization_scope :view_context
  
  def current_user
    @current_user ||= User.find_by_email('colinwarmstrong@gmail.com')
  end
end
