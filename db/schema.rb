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

ActiveRecord::Schema.define(version: 2020_04_22_040844) do

  create_table "authentications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "blacklists", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "user_id"
    t.integer "target_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_user_id"], name: "index_blacklists_on_target_user_id"
    t.index ["user_id", "target_user_id"], name: "index_blacklists_on_user_id_and_target_user_id", unique: true
    t.index ["user_id"], name: "index_blacklists_on_user_id"
  end

  create_table "joined_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "post_id"
    t.bigint "recruiting_position_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id", "recruiting_position_id"], name: "index_joined_users_on_post_id_and_recruiting_position_id", unique: true
    t.index ["post_id", "user_id"], name: "index_joined_users_on_post_id_and_user_id", unique: true
    t.index ["post_id"], name: "index_joined_users_on_post_id"
    t.index ["recruiting_position_id", "user_id"], name: "index_joined_users_on_recruiting_position_id_and_user_id", unique: true
    t.index ["recruiting_position_id"], name: "index_joined_users_on_recruiting_position_id", unique: true
    t.index ["user_id"], name: "index_joined_users_on_user_id"
  end

  create_table "posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "quest_name", null: false
    t.string "invite_url", null: false
    t.integer "member_capacity", default: 3, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "recruiting_positions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "character"
    t.text "description"
    t.bigint "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_recruiting_positions_on_post_id"
  end

  create_table "relationships", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "game_name"
    t.string "email"
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "avatar"
    t.string "access_token"
    t.string "access_token_secret"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "joined_users", "posts"
  add_foreign_key "joined_users", "recruiting_positions"
  add_foreign_key "joined_users", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "recruiting_positions", "posts"
end
