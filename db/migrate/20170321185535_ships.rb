class Ships < ActiveRecord::Migration[5.0]
  def change
    create_table :ships do |t|
      t.string :name
      t.integer :length
    end
  end
end
