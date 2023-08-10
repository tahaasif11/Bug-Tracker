class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  def after_sign_in_path_for(resource)
    # Customize the redirection path based on the resource (user) role or other criteria
      projects_path

  end



  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:typee])
   end 
end
