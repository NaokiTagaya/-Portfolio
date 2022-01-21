class ReviewsController < ApplicationController

  # レビュー投稿
  def new
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
  end

  # レビュー投稿処理
  def create
    @review = Review.new(review_params)
    if @review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to restaurant_path(id: @review.restaurant_id)
    else
      render "new"
    end
  end

  # レビュー削除処理
  def destroy
    
  end

  private
  def review_params
    params.require(:review).permit(:comment, :rate, :restaurant_id, :user_id)
  end
end
