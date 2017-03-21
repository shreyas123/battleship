class CreateGames < ActiveRecord::Migration[5.0]
  def change
    create_table :games do |t|
      t.datetime :started_at
      t.boolean :paused, default: false
      t.boolean :finished, default: false
      t.timestamps
    end
  end
end
