class Admin::TripArticleController < ApplicationController

  def destroy
    trip_article = TripArticle.find(params[:id])
    trip_article.destroy
    redirect_to admin_comment_index
  end

  private

  def trip_article_params
    params.require(:trip_article).permit(:title, :text, :image, :user_id, :comment)
  end
end
