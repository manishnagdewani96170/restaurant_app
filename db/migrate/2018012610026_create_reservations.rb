class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :guest_count
      t.string :reservation_time
      t.references :table, index: :true
      t.references :guest, index: :true
      t.references :restaurant, index: :true
      t.timestamps
    end
  end
end
