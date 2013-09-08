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

ActiveRecord::Schema.define(:version => 20130908121719) do

  create_table "performances", :force => true do |t|
    t.string   "place"
    t.string   "event"
    t.string   "description"
    t.datetime "time"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "filename"
    t.integer  "user_id"
    t.datetime "date_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "year"
    t.text     "bio"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "sunet"
    t.string   "gender"
    t.boolean  "is_admin"
    t.boolean  "is_alumni"
    t.boolean  "is_captain"
    t.string   "hometown"
    t.text     "memory"
    t.string   "major"
    t.string   "shirt_size"
    t.boolean  "is_undergrad"
    t.string   "residence"
    t.string   "food"
    t.string   "stanfordid"
    t.date     "birthday"
    t.string   "committee"
    t.string   "phone"
    t.string   "twitter"
    t.string   "facebook"
    t.text     "quote"
  end

  create_table "videos", :force => true do |t|
    t.string   "link"
    t.string   "description"
    t.string   "uploader"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "vid"
  end

end
