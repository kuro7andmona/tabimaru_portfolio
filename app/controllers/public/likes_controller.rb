class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    user = current_user
    trip_article_ids = Like.where(user_id: user.id).pluck(:trip_article_id)
    @trip_articles = TripArticle.find(trip_article_ids)
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
    trip_article = TripArticle.find(params[:trip_article_id])
    likes =  current_user.likes.find(params[:id])
    if trip_article.user != current_user
      redirect_to likes_path
    if likes.present?
      likes.destroy
    else
      redirect_back fallback_location: root_path
    end
  end
end

  private

  def like_params
    params.permit(:like)
  end

end
