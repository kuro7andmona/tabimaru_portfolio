class Public::TripArticlesController < ApplicationController

  def new
    @trip_article = TripArticle.new
  end

  def create
    @trip_article = TripArticle.new(trip_article_params)
    @trip_article.user_id = current_user.id
    @trip_article.save
    redirect_to trip_articles_path
  end

  def index
    @trip_articles = TripArticle.all
  end

  def show
     @trip_article = TripArticle.find(params[:id])
     @comment = Comment.new
  end

  def edit
  end

  def update
  end

  def destoroy

  end

  private

  def trip_article_params
    params.require(:trip_article).permit(:title, :text, :image, :user_id, :comment)
  end

end
