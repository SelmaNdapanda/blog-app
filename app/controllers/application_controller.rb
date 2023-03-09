class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index show]

  protect_from_forgery with: :exception

  before_action :update_allowed_parameters, if: :devise_controller?

  # To redirect users to see all users after sign up
  def after_sign_up_path_for(_resource)
    users_path
  end

  # Determine where to redirect user after successful login.
  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :photo, :bio, :email, :password, :password_confirmation)
    end
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :photo, :bio, :email, :password, :password_confirmation, :current_password)
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
