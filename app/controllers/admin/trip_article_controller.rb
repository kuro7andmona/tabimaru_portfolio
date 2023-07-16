class Admin::TripArticleController < ApplicationController
  before_action :authenticate_admin!
  def destroy
    trip_article = TripArticle.find(params[:id])
    trip_article.destroy
    redirect_to admin_comments_path
  end

  private

  def trip_article_params
    params.require(:trip_article).permit(:trip_article_id)
  end
end
