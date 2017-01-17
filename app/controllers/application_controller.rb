class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    sign_in_url = "/about_us"
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || request.referer || "/resources"
    end
  end

end
