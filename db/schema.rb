# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170321192123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.datetime "started_at"
    t.boolean  "paused",     default: false
    t.boolean  "finished",   default: false
    t.integer  "player1_id"
    t.integer  "player2_id"
    t.integer  "move",       default: 1
    t.integer  "won_by",     default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["player1_id"], name: "index_games_on_player1_id", using: :btree
    t.index ["player2_id"], name: "index_games_on_player2_id", using: :btree
  end

  create_table "moves", force: :cascade do |t|
    t.integer "game_id"
    t.integer "ship_sunk_id"
    t.integer "player_number"
    t.string  "vertical_move"
    t.integer "horizontal_move"
    t.boolean "hit",             default: false
    t.index ["game_id"], name: "index_moves_on_game_id", using: :btree
    t.index ["ship_sunk_id"], name: "index_moves_on_ship_sunk_id", using: :btree
  end

  create_table "placements", force: :cascade do |t|
    t.integer "game_id"
    t.integer "ship_id"
    t.integer "player_number"
    t.boolean "vertical",             default: false
    t.text    "vertical_placement"
    t.integer "horizontal_placement"
    t.index ["game_id", "ship_id"], name: "index_placements_on_game_id_and_ship_id", unique: true, using: :btree
    t.index ["game_id"], name: "index_placements_on_game_id", using: :btree
    t.index ["ship_id"], name: "index_placements_on_ship_id", using: :btree
  end

  create_table "players", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ships", force: :cascade do |t|
    t.string  "name"
    t.integer "length"
  end

end
