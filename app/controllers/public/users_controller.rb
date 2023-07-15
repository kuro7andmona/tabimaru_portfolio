class Public::UsersController < ApplicationController
　before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @trip_articles = TripArticle.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to users_mypage_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :image, :introduction, :user_id, :like)
  end
  
  def authenticate_user
    unless user_signed_in? # ①
      redirect_to new_user_session_path # ②
    end
  end
end
