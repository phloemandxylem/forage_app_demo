class ApplicationController < ActionController::Base
      include Pundit

      protect_from_forgery with: :exception

        #Handle Pundit when a request is denied
        rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

        #before_action :authenticate_user!
        before_action :configure_permitted_parameters, if: :devise_controller?

        def after_sign_in_path_for(resource)
          # Display user profile after sign-in
          wikis_path
        end

        def configure_permitted_parameters
          devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :role])
          devise_parameter_sanitizer.permit(:account_update, keys: [:name, :role] )
        end

        private
        def user_not_authorized
          flash[:alert] = "You are not authorized to perform this action."
          redirect_to(request.referrer || root_path)
        end
      end
