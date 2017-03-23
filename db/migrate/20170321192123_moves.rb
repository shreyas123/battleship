class Moves < ActiveRecord::Migration[5.0]
  def change
    create_table :moves do |t|
      t.references :game
      t.integer :player_number
      t.string :vertical_move
      t.integer :horizontal_move
      t.boolean :hit, default: false
    end
  end
end
