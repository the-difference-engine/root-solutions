class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)
    sign_in_url = "/"
    if request.referer == sign_in_url
      super
    else
      stored_location_for(resource) || "/resources"
    end
  end

end
