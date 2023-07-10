class Admin::CommentsController < ApplicationController

  def create
    @trip_article = TripArticle.find(params[:trip_article_id])
    @comment = @trip_article.comments.new(comment_params)
    @comment.user_id = current_user.id
    comment.save
    redirect_to admin_comment_index_path
  end

  private

  def comment_params
    params.require(:comment).permit(:comment,:user_id, :trip_article_id)
  end
end
