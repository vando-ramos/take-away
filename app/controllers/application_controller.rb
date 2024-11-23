class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

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
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name last_name cpf])
  end

  def authorize_admin!
    redirect_to root_path, alert: 'Access denied' unless current_user&.admin?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
