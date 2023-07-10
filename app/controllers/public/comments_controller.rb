class Public::CommentsController < ApplicationController

  def create
    @trip_article = TripArticle.find(params[:trip_article_id])
    @comment = @trip_article.comments.new(comment_params)
    @comment.user_id = current_user.id
    comment.save
    render trip_article(@trip_article)
  end

   def destroy
    Comment.find(params[:id]).destroy
    redirect_to trip_article_path(params[:trip_article_id])
   end

  private

  def comment_params
    params.require(:comment).permit(:comment, :user_id, :trip_article_id)
  end

end
