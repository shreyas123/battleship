class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.datetime :started_at
      t.boolean :paused, default: false
      t.boolean :finished, default: false
      t.references :player1
      t.references :player2
      t.integer :move, default: 1
      t.integer :won_by, default: 0
      t.timestamps
    end
  end
end
