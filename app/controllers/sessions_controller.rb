class SessionsController < ApplicationController
  
  def new
    @session = Session.new
  end
  
  def create
    @session = Session.new(params[:session])
    if login(@session)
      redirect_to root_path, :notice => "#{t("message.welcome")} #{@session.user.name}"
    else
      render :new
    end
  end
  
  def destroy
    logout
    redirect_to root_path, :notice => t("message.logout_success")
  end
end