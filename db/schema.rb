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

ActiveRecord::Schema.define(version: 20151216051441) do

  create_table "answer_options", force: true do |t|
    t.integer  "question_id"
    t.string   "option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: true do |t|
    t.integer  "answerer_id"
    t.string   "comments"
    t.string   "picture_url"
    t.integer  "answer_option_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id1"
    t.integer  "user_id2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.integer  "creator_id"
    t.string   "name"
    t.string   "description"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "members", force: true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pictures", force: true do |t|
    t.integer  "question_id"
    t.string   "picture_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.integer  "creator_id"
    t.string   "question_text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "open"
    t.boolean  "allow_comments"
    t.string   "picture"
    t.boolean  "ask_friends"
    t.boolean  "ask_public"
    t.integer  "ask_group"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_digest"
    t.string   "password_digest"
    t.string   "phone_number"
  end

end
