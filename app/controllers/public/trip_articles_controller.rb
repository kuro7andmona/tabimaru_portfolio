class Public::TripArticlesController < ApplicationController

  def new
    @trip_article = TripArticle.new
  end

  def create
    @trip_article = TripArticle.new(trip_article_params)
    @trip_article.user_id = current_user.id
    if @trip_article.save
      flash[:notice] = "投稿しました！"
    redirect_to trip_articles_path
    else
      render :index
    end
  end

  def index
    @trip_articles = TripArticle.page(params[:page])
  end

  def show
     @trip_article = TripArticle.find(params[:id])
     @comment = Comment.new
     @comments = Comment.all
  end

  def edit
    @trip_article = TripArticle.find(params[:id])
  end

  def update
    trip_article = TripArticle.find(params[:id])
   if trip_article.update(trip_article_params)
     flash[:notice] = "編集しました"
    redirect_to trip_article(@trip_article)
   else
     render :edit
   end
  end

  def destoroy

  end

  private

  def trip_article_params
    params.require(:trip_article).permit(:title, :text, :image, :user_id, :comment_id, :like_id)
  end

end
