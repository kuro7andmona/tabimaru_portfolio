class Admin::CommentsController < ApplicationController

  def index
    @trip_articles = TripArticle.all
    @comments = Comment.all
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_trip_article_comments_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:user_id, :trip_article_id)
  end
end
