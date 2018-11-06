class SessionsController < ApplicationController
  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user
    else
      render json: {message: 'Invalid login credentials.'}
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {message: 'Succesfully logged out'}
  end
end
