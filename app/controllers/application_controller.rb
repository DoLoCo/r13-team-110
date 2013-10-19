class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end
  helper_method :permitted_params

protected

  def devise_parameter_sanitizer
    User::ParameterSanitizer.new(User, :user, params)
  end

end
