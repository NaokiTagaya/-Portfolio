class RestaurantsController < ApplicationController
  def top
  end

  def new
    @restaurant = Restaurant.new
  end
end
