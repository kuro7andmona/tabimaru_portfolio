class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_guest_user, only: [:edit]



  def index
    @users = User.page(params[:page])
  end

  def show
    @users = current_user
    @user = User.find(params[:id])
    @trip_articles = @user.trip_articles
    @tags = Tag.all
    @trip_articles = @trip_articles.where("text LIKE ? ",'%' + params[:search] + '%') if params[:search].present?
    if params[:tag_ids].present?
        trip_article_ids = []
        params[:tag_ids].each do |key, value|
            if value == "1"
            Tag.find_by(name: key).posts.each do |p|
            trip_article_ids << p.id
            end
            end
        end
    end

    @trip_articles = @trip_articles.where(id: trip_article_ids) if trip_article_ids.present?

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to users_mypage_path(@user)
    else
      render :edit
    end
  end

  def other_user
   @user = User.find(params[:id])
   @trip_articles = @user.trip_articles
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
