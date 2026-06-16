class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :authenticate_user!, unless: :devise_controller?

  private

    def after_sign_in_path_for(_resource)
      root_path
    end
end
