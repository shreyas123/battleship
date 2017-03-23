class Placements < ActiveRecord::Migration[5.0]
  def change
    create_table :placements do |t|
      t.references :game
      t.references :ship
      t.integer :player_number, index: true
      t.boolean :vertical, default: false
      t.text :vertical_placement
      t.integer :horizontal_placement
    end

    add_index :placements, [:game_id, :ship_id]
    add_index :placements, [:game_id, :ship_id, :player_number]
  end
end
