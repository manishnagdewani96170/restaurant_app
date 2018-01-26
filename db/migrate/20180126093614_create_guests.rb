class CreateGuests < ActiveRecord::Migration[5.0]
  def change
    create_table :guests do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
