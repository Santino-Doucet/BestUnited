class ApplicationController < ActionController::Base
  # [...]
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_stock

  private

  def current_stock
    if current_user&.companies&.first
      company = current_user.companies.first
      return company.items
    end
    []
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :age, :gender, :address, :longitude, :latitude, :phone_number])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :age, :gender, :address, :longitude, :latitude, :phone_number])
  end
end
