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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160713091602) do

  create_table "oauths", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "openid"
    t.string   "nickname"
    t.integer  "sex"
    t.string   "city"
    t.string   "province"
    t.string   "country"
    t.string   "headimgurl"
    t.text     "privilege"
    t.boolean  "subscribe"
    t.date     "subscribed_at"
    t.string   "unionid"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "qrcodes", force: :cascade do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "action_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "nickname"
    t.string   "avatar_url"
    t.integer  "register_from_type"
    t.datetime "last_login"
    t.string   "last_ip"
    t.string   "mobile"
    t.string   "mobile_verify_token"
    t.boolean  "mobile_verified",     default: false
    t.string   "email"
    t.string   "email_verify_token"
    t.boolean  "email_verified",      default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

end
