class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :profile_name, :email, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :profile_name, :email, :password, :password_confirmation])
  end

  def profiles_params
      params.require(user).permit(:user_id, :friend_id, :users, :friend, :state, :first_name, :last_name, :user_friendship, :full_name, :album, :albums_thumbnail, :title)
  end
end
