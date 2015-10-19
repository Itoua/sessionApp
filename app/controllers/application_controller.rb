class ApplicationController < ActionController::Base

  include Pundit

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, :if => :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected
 
     def configure_permitted_parameters
       devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :surname, :dob.to_s, :email, :password, :password_confirmation, :role)}
       devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :surname, :dob.to_s, :email, :password, :password_confirmation, :current_password, :role)}
     end
                                 
 private
     def permission_denied
        flash.now[:notice] = "You are not allowed here"
        #redirect_to (request.referrer || root_path)
        redirect_to articles_path
     end   

     def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to articles_path
    end                             
end
