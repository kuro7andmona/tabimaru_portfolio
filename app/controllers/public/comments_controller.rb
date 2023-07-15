class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @trip_article = TripArticle.find(params[:trip_article_id])
    comment = current_user.comments.new(comment_params)
    comment.trip_article_id = @trip_article.id
    if comment.save
    redirect_to trip_article_path(@trip_article)
    else
      redirect_to root_path
    end
  end

   def destroy
    Comment.find(params[:id]).destroy
    redirect_to trip_article_path(params[:trip_article_id])
   end

  private

  def comment_params
     params.require(:comment).permit(:comment, :trip_article, :user_id)
  end

end