class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :restaurant_name
      t.string :tel
      t.string :zipcode
      t.string :address
      t.integer :registered_user_id

      t.timestamps
    end
  end
end
