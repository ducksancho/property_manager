include SignupCodeHelper

class UsersController < ApplicationController
  before_filter :authentication, :except => [:new, :create]

  def new
    @user = User.new(:signup_code => params[:signup_code])
    redirect_on_invalid_signup_code @user
  end

  def create
    @user = User.new(params[:user])
    return if redirect_on_invalid_signup_code @user
    if @user.save
      login(Session.new({
        :email => params[:user][:email], 
        :password => params[:user][:password]}))
      redirect_to root_path, :notice => t("message.user_registered")
    else
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
    authorize! :read, @user
  end
  
  def edit
    @user = User.find(params[:id])
    authorize! :update, @user
  end

  def update
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update_attributes(params[:user].except(:password, :password_confirmation))
      redirect_to root_path, :notice => t("message.user_updated")
    else
      render :edit
    end    
  end
  
  def edit_password
    @user = User.find(params[:id])
  end
  
  def update_password
    @user = User.find(params[:id])
    authorize! :update, @user
    if @user.update_attributes(params[:user].merge(:update_password => 1))
      redirect_to root_path, :notice => t("message.password_updated")
    else
      render :edit_password
    end        
  end  
end
