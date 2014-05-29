class Api::V1::UserController < ApplicationController
  respond_to :json, :html

  before_filter :restrict_access


  def show
    respond_to do |format|
      format.json { render json: @user.to_json(:only => [:id, :private_key]) }
      format.html { redirect_to root_path }
    end
  end

  private
  
  def restrict_access
    unless current_user
      Rails.logger.info "Current User #{current_user}"
      @user ||= User.find_by_id_and_auth_token params[:id]||'', request.headers['Auth-Token']
      Rails.logger.info "Post Current User #{current_user}"
      redirect_to root_path unless @user
    else
      redirect_to root_path
    end
  end

end