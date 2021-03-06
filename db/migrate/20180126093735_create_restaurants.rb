class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :morning_start_shift
      t.string :morning_end_shift
      t.string :evening_start_shift
      t.string :evening_end_shift 
      t.timestamps
    end
  end
end
