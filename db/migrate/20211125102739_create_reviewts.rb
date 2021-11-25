class CreateReviewts < ActiveRecord::Migration[5.2]
  def change
    create_table :reviewts do |t|
      t.integer :restaurant_id
      t.integer :user_id
      t.text :comment
      t.float :rate

      t.timestamps
    end
  end
end
