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

ActiveRecord::Schema.define(version: 20170807133420) do

  create_table "accesses", id: :string, force: :cascade do |t|
    t.string "user_id", null: false
    t.string "accessable_id", null: false
    t.string "accessable_type", null: false
    t.integer "access_level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessable_id"], name: "index_accesses_on_accessable_id"
    t.index ["id"], name: "sqlite_autoindex_accesses_1", unique: true
    t.index ["user_id"], name: "index_accesses_on_user_id"
  end

  create_table "comments", id: :string, force: :cascade do |t|
    t.text "content", null: false
    t.string "user_id", null: false
    t.string "commentable_id", null: false
    t.string "commentable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["id"], name: "sqlite_autoindex_comments_1", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "type", null: false
    t.string "actor_id", null: false
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.string "project_id", null: false
    t.string "team_id", null: false
    t.string "action", null: false
    t.string "value"
    t.string "old_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_events_on_actor_id"
    t.index ["project_id"], name: "index_events_on_project_id"
    t.index ["resource_id"], name: "index_events_on_resource_id"
    t.index ["team_id"], name: "index_events_on_team_id"
  end

  create_table "projects", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "sqlite_autoindex_projects_1", unique: true
    t.index ["team_id"], name: "index_projects_on_team_id"
  end

  create_table "teams", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "sqlite_autoindex_teams_1", unique: true
  end

  create_table "todos", id: :string, force: :cascade do |t|
    t.string "title", null: false
    t.text "content"
    t.string "project_id", null: false
    t.integer "state", default: 0, null: false
    t.string "creator_id", null: false
    t.string "owner_id"
    t.date "due_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "sqlite_autoindex_todos_1", unique: true
    t.index ["project_id"], name: "index_todos_on_project_id"
  end

  create_table "users", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "sqlite_autoindex_users_1", unique: true
  end

end
