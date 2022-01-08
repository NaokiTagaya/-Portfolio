class RestaurantsController < ApplicationController
  def top
  end

  def search

  end
  
  def new
    @restaurant = Restaurant.new
  end
end
