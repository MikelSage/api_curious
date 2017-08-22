class SessionsController < ApplicationController
  def create
    user = User.update_or_create(request.env['omniauth.auth'])
    session[:user_id] = user.id
    
    redirect_to root_path
  end
end
