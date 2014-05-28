class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception




  def update_devise_parameter_sanitizer
    devise_parameter_sanitizer.for(:sign_up)
    # devise_parameter_sanitizer.for(:account_update).push(:kind,:avatar)
  end


  private 
  

end
