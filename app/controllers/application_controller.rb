class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def logged_in?
    if current_user.nil?
      render 'index'
      return
    end
  end
end
