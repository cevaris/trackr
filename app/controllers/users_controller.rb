class UsersController < ApplicationController

  # def current_user
  #   # puts params
  #   # puts request.headers
  #   current_user ||= User.find_by_id_and_auth_token params[:id], request.headers['Auth-Token'] if params.has_key?(:id)
  # end

  def show
    current_user ||= User.find_by_id_and_auth_token params[:id], request.headers['Auth-Token'] if params.has_key?(:id)

    respond_to do |format|
      format.json { render json: current_user.to_json(:only => [:id, :private_key]) }
      format.html
    end
  end
end
