class UsersController < ApplicationController
  def new
    if params[:signup_code]
      @user = User.new(:signup_code => params[:signup_code])
    else
      redirect_to root_path, :notice => t("message.no_signup_without_signup_code")
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => t("message.user_registered")
    else
      render :new
    end
  end

  def edit
  end

  def update
  end
end
