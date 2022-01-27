class FavoritesController < ApplicationController
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    if @restaurant.registered_user_id != current_user.id
      @favorite = Favorite.create(user_id: current_user.id, restaurant_id: @restaurant.id)
    end
  end

  def destroy
    @Restaurant = Restaurant.find(params[:restaurant_id])
    @favorite = Favorite.find_by(user_id: current_user.id, restaurant_id: @restaurant.id)
    @favorite.destroy
  end
end
