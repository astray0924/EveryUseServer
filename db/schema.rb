# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120726015528) do

  create_table "favorites", :force => true do |t|
    t.integer  "user_id"
    t.integer  "use_case_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "favorites", ["user_id", "use_case_id"], :name => "index_favorites_on_user_id_and_use_case_id", :unique => true

  create_table "metoos", :force => true do |t|
    t.integer  "user_id"
    t.integer  "use_case_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "metoos", ["user_id", "use_case_id"], :name => "index_metoos_on_user_id_and_use_case_id", :unique => true

  create_table "relationships", :force => true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["followed_id"], :name => "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], :name => "index_relationships_on_follower_id_and_followed_id", :unique => true
  add_index "relationships", ["follower_id"], :name => "index_relationships_on_follower_id"

  create_table "use_cases", :force => true do |t|
    t.string   "item"
    t.string   "purpose"
    t.string   "purpose_type"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.integer  "user_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "favorites_count",    :default => 0,  :null => false
    t.integer  "wows_count",         :default => 0,  :null => false
    t.integer  "metoos_count",       :default => 0,  :null => false
    t.string   "user_group",         :default => ""
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "use_cases_count",     :default => 0
    t.string   "single_access_token", :default => "", :null => false
    t.integer  "favorites_count",     :default => 0,  :null => false
    t.integer  "wows_count",          :default => 0,  :null => false
    t.integer  "metoos_count",        :default => 0,  :null => false
  end

  create_table "wows", :force => true do |t|
    t.integer  "user_id"
    t.integer  "use_case_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "wows", ["user_id", "use_case_id"], :name => "index_funs_on_user_id_and_use_case_id", :unique => true

end
