class Moves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.references :game
      t.references :ship_sunk
      t.integer :player_number
      t.boolean :hit, default: false
    end
  end
end
