class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :nickname
      t.integer :sex
      t.integer :age
      t.string :email
      t.string :password
      t.string :password_confirmation

      t.timestamps
    end
  end
end
