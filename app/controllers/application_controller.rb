class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    new_establishment_path
  end

  def after_sign_in_path_for(resource)
    if resource.establishment.present?
      root_path
    else
      new_establishment_path
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name last_name identification_number])
  end
end
