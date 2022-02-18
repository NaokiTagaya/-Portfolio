class FavoritesController < ApplicationController
  before_action :set_restaurant
  #before_action :authenticate_user!

  def create
    if @restaurant.registered_user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, restaurant_id: @restaurant.id)
    end
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, restaurant_id: @restaurant.id)
    @favorite.destroy
  end

  private
    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end
end
