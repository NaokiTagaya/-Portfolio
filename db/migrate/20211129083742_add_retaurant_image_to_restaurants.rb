class AddRetaurantImageToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :restaurant_image, :string
  end
end
