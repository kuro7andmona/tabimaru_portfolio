class Public::UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_mypage_path(user_mypage)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :image, :introduction)
  end
end
