class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @trip_articles = TripArticle.all
    @comments = Comment.all
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to admin_comments_path
  end

  private

  def comment_params
    params.require(:comment)
  end
end
