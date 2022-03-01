class ReviewsController < ApplicationController
  before_action :authenticate_user!

  # レビュー投稿
  def new
    @restaurant = Restaurant.find(params[:id])
    @review = Review.new
  end

  # レビュー投稿処理
  def create
    @review = Review.new(review_param)
    if @review.save
      flash[:notice] = "レビューを投稿しました"
      redirect_to restaurant_path(id: @review.restaurant_id)
    else
      redirect_to new_review_path(id: @review.restaurant_id), flash: { error: @review.errors.full_messages }
    end
  end

  # レビュー削除処理
  def destroy
    review = Review.find(params[:id])
    if review.user_id == current_user.id
      review.destroy
      flash[:notice] = "投稿したレビューを削除しました"
      redirect_to root_path
    end
  end

  private
    def review_param
      params.require(:review).permit(:comment, :rate, :restaurant_id, :user_id)
    end
end
