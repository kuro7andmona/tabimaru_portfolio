class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = User.find(params[:id])
    likes = Like.where(user_id: user.id).pluck(:trip_article_id)
    @likes = TripArticle.find(likes)
  end

  def create
    @trip_article = TripArticle.find(params[:trip_article_id])
    like = @trip_article.likes.build(user_id: current_user.id)
    if like.save
    else
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    @trip_article = TripArticle.find(params[:trip_article_id])
    like =  current_user.likes.find(params[:id])
    if like.present?
      like.destroy
    else
      redirect_back fallback_location: root_path
    end
  end

  private

  def like_params
    params.permit(:like)
  end

end
