include SignupCodeHelper

class UsersController < ApplicationController
  def new
    @user = User.new(:signup_code => params[:signup_code])
    redirect_on_invalid_signup_code @user
  end

  def create
    @user = User.new(params[:user])
    redirect_on_invalid_signup_code @user
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
