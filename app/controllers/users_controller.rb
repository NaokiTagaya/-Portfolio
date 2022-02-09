class UsersController < ApplicationController
  def show
    @user = current_user
    @restaurants = Restaurant.where(registered_user_id: @user.id)
    @reviews = Review.where(user_id: current_user.id)
    favorites = Favorite.where(user_id: current_user.id).order(created_at: :desc).pluck(:restaurant_id)
    @favorites = Restaurant.find(favorites)
  end

  private
    def user_params
      params.require(:user).permit(:image, :user_name, :age, :sex, :email, :password)
    end
end
