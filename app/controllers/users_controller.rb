class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_path, :notice => t("message.user_registered")
    else
      flash.now[:notice] = "aaa"
      render :new
    end
  end

  def edit
  end

  def update
  end
end
