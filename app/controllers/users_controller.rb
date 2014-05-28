class UsersController < ApplicationController
  def show
    respond_to do |format|
      format.json { render json: current_user.to_json(:only => [:id, :auth_token]) }
      format.html
    end
  end
end
