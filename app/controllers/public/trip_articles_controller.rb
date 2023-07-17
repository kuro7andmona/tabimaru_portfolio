class Public::TripArticlesController < ApplicationController
 before_action :authenticate_user!
  def new
    @trip_article = TripArticle.new
  end

  def create
    @trip_article = TripArticle.new(trip_article_params)
    @trip_article.user_id = current_user.id
    if @trip_article.save
      # if params[:trip_article][:prefecture_id].present?
      #   AssociationTripArticleandTag.create(trip_articl_id: @trip_article, tag_id: params[:trip_article][:prefecture_id], tag_type: 0)
      # end
      # if params[:trip_article][:season_id].present?
      #   AssociationTripArticleandTag.create(trip_articl_id: @trip_article, tag_id: params[:trip_article][:season_id], tag_type: 1)
      # end
      flash[:notice] = "投稿しました！"
      redirect_to trip_articles_path
    else
       @trip_articles = TripArticle.all
       @tags = Tag.all
       @user = current_user
      render :index
    end
  end

  def index
    @trip_articles = TripArticle.all
    @user = current_user
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
    @trip_articles = @trip_articles.page(params[:page])
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

  def search
    @tag = Prefecture_names.all
    @tags = Prefecture_season_names.all
    @tag = Tag.find(params[:tag_id])
    @trip_articles = @tag.trip_articles.all
  end

  def destroy

  end

  private

  def trip_article_params
    params.require(:trip_article).permit(:title, :text, :image, :user_id, :comment_id, :like, :prefecture_id, :season_id)
  end

end
