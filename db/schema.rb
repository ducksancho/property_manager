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

ActiveRecord::Schema.define(:version => 20130414070233) do

  create_table "notes", :force => true do |t|
    t.string   "note"
    t.integer  "notable_id"
    t.string   "notable_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "photo"
    t.integer  "photoable_id"
    t.string   "photoable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "properties", :force => true do |t|
    t.string   "city"
    t.string   "suburb"
    t.string   "street"
    t.string   "postcode"
    t.integer  "n_bathroom"
    t.integer  "n_room"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "creator_id"
    t.integer  "main_photo_id"
  end

  create_table "users", :force => true do |t|
    t.string   "f_name"
    t.string   "l_name"
    t.string   "email"
    t.string   "salt"
    t.string   "encrypted_password"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "signup_code"
  end

end
