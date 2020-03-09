class SessionsController < ApplicationController
  def create
    current_user = User.authenticate_with_credential(params[:email], params[:password])
    if current_user
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end
