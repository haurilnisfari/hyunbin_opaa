class SessionsController < ApplicationController

  def new
  end

  def create
    username = params[:username]
    password = params[:password]

    account = Account.find_by_username(username)
    if account
      if account.authenticate(password)
        session[:account_id] = account.id
        redirect_to root_path, notice: "Logged in!"
      else
        redirect_to new_session_path, notice: 'Username atau password salah'
      end
    else
      redirect_to new_session_path, notice: 'Username atau password salah'
    end
  end

  def destroy
    session[:account_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
