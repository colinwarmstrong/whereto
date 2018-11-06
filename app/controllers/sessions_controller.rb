class SessionsController < ApplicationController
  def create
    user = User.find_by_email(session_params[:email])
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      render json: user, status: 200
    else
      render json: {message: 'Invalid login credentials.'}
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {message: 'Succesfully logged out'}, status: 200
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
