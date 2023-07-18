class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]


  def ensure_guest_user
    if resource.email == 'guest@guest.mail'
    redirect_to user_path(@user.id), notice: 'ゲストユーザーは編集できません'
    end
  end

  def index
    @users = User.all
  end

  def show
    @users = current_user
    @user = User.find(params[:id])
    @trip_articles = @user.trip_articles
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
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def ensure_guest_user
   if current_user.guest_user?
     redirect_to users_mypage_path(current_user), notice: "ゲストユーザーはプロフィール編集できません。"
   end
  end


end
