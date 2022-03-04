class ApplicationController < ActionController::Base
  protect_from_forgery prepend: true
  # before_action :authenticate_with_token
  before_action :authenticate_user!, unless: :api_path
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def api_path
    request.original_url.include?('api')
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name bio photo])
  end

  # def authenticate_with_token
  #   if request.original_url.include?('posts')
  #     if request.headers["X-AUTH-TOKEN"]
  #       user = User.find_by_api_token(request.headers["X-AUTH-TOKEN"])
  #       return true
  #     end
  #   end
  #   return false
  # end
end
