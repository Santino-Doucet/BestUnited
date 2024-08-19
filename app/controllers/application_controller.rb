class ApplicationController < ActionController::Base
  # [...]
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:age, :gender, :address, :longitude, :latitude, :phone_number])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:age, :gender, :address, :longitude, :latitude, :phone_number])
  end
end
