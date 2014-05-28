class UsersController < ApplicationController

  before_filter :restrict_access


  def show
    respond_to do |format|
      format.json { render json: @user.to_json(:only => [:id, :private_key]) }
      format.html
    end
  end

  private
  
  def restrict_access
    unless current_user
      Rails.logger.info "Current User #{current_user}"
      @user ||= User.find_by_id_and_auth_token params[:id]||'', request.headers['Auth-Token']
      Rails.logger.info "Post Current User #{current_user}"
      head :unauthorized unless @user
    else
      @user = current_user
    end
  end

end
