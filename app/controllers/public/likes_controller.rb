class Public::LikesController < ApplicationController
  before_action :authenticate_user!

  def index
    # @user = current_user
    @user = User.find(params[:id])
    likes = Like.where(user_id: @user.id).pluck(:trip_article_id)
    @likes = TripArticle.find(likes)
  end

  def create
    @like = current_user.likes.build(like_params)
    @trip_article = @like.trip_article
    if @like.valid?
      @like.save
      redirect_to trip_articles_path(@trip_article)
    end
  end

  def destroy
    @like = Like.find(params[:id])
    @trip_article = @like.trip_article
    if @like.destroy
      redirect_to trip_article_path(@trip_article)
    end
  end

  private

  def like_params
    params.require(:like).permit(:trip_article_id, :user_id)
  end

end
