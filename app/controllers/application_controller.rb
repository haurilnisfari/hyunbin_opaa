class ApplicationController < ActionController::Base
  helper_method :current_account

  def current_account
    if session[:account_id]
      @current_account ||= Account.find(session[:account_id])
    else
      @current_account = nil
    end
  end
end
