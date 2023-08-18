class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    # Customize the redirection path based on the resource (user) role or other criteria
      projects_path
  end

  def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name,:user_type])
     devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :current_password_confirmation, :user_type)}
  end 
end
