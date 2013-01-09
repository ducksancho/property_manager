include SignupCodeHelper

class UsersController < ApplicationController
  def new
    @user = User.new(:signup_code => params[:signup_code])
    redirect_on_invalid_signup_code @user
  end

  def create
    @user = User.new(params[:user])
    return if redirect_on_invalid_signup_code @user
    if @user.save
      redirect_to root_path, :notice => t("message.user_registered")
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update_columns(params[:user])
      redirect_to root_path, :notice => t("message.user_updated")
    else
      render :edit
    end    
  end
end
