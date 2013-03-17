class ApplicationController < ActionController::Base
  include ApplicationHelper
  protect_from_forgery
  
  rescue_from CanCan::AccessDenied do |exception|    
    redirect_to root_path, :alert => t("message.access_denied")
  end
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to root_path, :alert => t("message.record_not_found")
  end
end
