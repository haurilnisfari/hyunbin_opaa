class SessionsController < ApplicationController
  layout false

  def new
  end

  def create
    username = params[:username]
    password = params[:password]

    user = User.find_by_username(username)
    if user
      if user.authenticate(password)
        session[:user_id] = user.id
        redirect_to expenses_path, notice: "Logged in!"
      else
        redirect_to new_session_path, notice: 'Username or password invalid'
      end
    else
      redirect_to new_session_path, notice: 'Username or password invalid'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
