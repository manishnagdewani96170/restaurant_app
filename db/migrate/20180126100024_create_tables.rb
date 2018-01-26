class CreateTables < ActiveRecord::Migration[5.0]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :maximum_count
      t.integer :minimum_count
      t.references :restaurant, index: :true
      t.timestamps
    end
  end
end
