class RegistrationsController < Devise::RegistrationsController  
  respond_to :json, :html
  

  def new
    # super

    build_resource({})
    # respond_with self.resource

    # Adding CSRF token
    response.headers['X-CSRF-Token'] = form_authenticity_token
    
    respond_to do |format|
      format.html { respond_with 'new', self.resource }
      format.json { head :ok }
    end   
    
  end

  def create
    # super

    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        # respond_with resource, location: after_sign_up_path_for(resource)
        # response.headers['auth_token'] = resource.auth_token
        respond_to do |format|
          format.json { render json: resource.to_json(:only => [:id, :auth_token]) }
          format.html { redirect_to resource }
        end
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      # respond_with resource
    end




  end

end