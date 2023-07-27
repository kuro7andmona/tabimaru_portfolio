class Public::SearchesController < ApplicationController

   before_action :authenticate_user!

  def search
    #:keyword 言葉
    #:model_name 投稿を検索するアソシエーションモデルの名前 prefecture season
    #:search_kind 検索方法　perfect_match　partinal_match
    @trip_articles = TripArticle.includes(:prefecture).includes(:season)
    if params[:search_kind] == "perfect_match"
      models = params[:model_name].camelize.constantize.where(name: params[:keyword])
    elsif params[:search_kind] == "partinal_match"
      models = params[:model_name].camelize.constantize.where("name LIKE ?", "%#{params[:keyword]}%")
    end
    @trip_articles = @trip_articles.where("#{params[:model_name]}_id": models.ids) if params[:keyword].present? 
    @trip_articles = @trip_articles.page(params[:page])
     flash[:notice] = "検索失敗しました"
    render 'public/trip_articles/index'
    
    
    
    # @range = params[:range]
    # @word = params[:word]
    # if (params[:keyword])[0] == '#'
    #   Prefecture.data = Tag.search(params[:keyword]).order('created_at DESC')
    # else
    #   Prefecture.data  = Prefecture.data.search(params[:keyword]).order('created_at DESC')
    # end

  end

end
