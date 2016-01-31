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

ActiveRecord::Schema.define(version: 20140515061230) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "categories", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true, using: :btree

  create_table "cities", force: true do |t|
    t.string   "name",       limit: 50, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cities", ["name"], name: "index_cities_on_name", unique: true, using: :btree

  create_table "clarifications", force: true do |t|
    t.integer  "request_id",   null: false
    t.integer  "clarify_id",   null: false
    t.string   "clarify_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description",  null: false
  end

  add_index "clarifications", ["clarify_id"], name: "index_clarifications_on_clarify_id", using: :btree
  add_index "clarifications", ["clarify_type"], name: "index_clarifications_on_clarify_type", using: :btree
  add_index "clarifications", ["request_id"], name: "index_clarifications_on_request_id", using: :btree

  create_table "contact_reasons", force: true do |t|
    t.string   "reason",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contact_reasons", ["reason"], name: "index_contact_reasons_on_reason", unique: true, using: :btree

  create_table "contacts", force: true do |t|
    t.string   "name",                              null: false
    t.string   "email",                             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "contact_reason_id",                 null: false
    t.text     "comment",                           null: false
    t.boolean  "replied",           default: false, null: false
  end

  add_index "contacts", ["contact_reason_id"], name: "index_contacts_on_contact_reason_id", using: :btree
  add_index "contacts", ["replied"], name: "index_contacts_on_replied", using: :btree

  create_table "favourites", force: true do |t|
    t.integer  "request_id", null: false
    t.integer  "vendor_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favourites", ["request_id", "vendor_id"], name: "index_favourites_on_request_id_and_vendor_id", unique: true, using: :btree

  create_table "highlights", force: true do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.integer  "vendor_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "highlights", ["vendor_id"], name: "index_highlights_on_vendor_id", using: :btree

  create_table "organisers", force: true do |t|
    t.string   "email",                             default: "",   null: false
    t.string   "encrypted_password",                default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                                       null: false
    t.string   "last_name",                                        null: false
    t.string   "mobile",                 limit: 17,                null: false
    t.string   "username",               limit: 25,                null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "city_id",                                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                   default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "approved",                          default: true, null: false
  end

  add_index "organisers", ["approved"], name: "index_organisers_on_approved", using: :btree
  add_index "organisers", ["city_id"], name: "index_organisers_on_city_id", using: :btree
  add_index "organisers", ["confirmation_token"], name: "index_organisers_on_confirmation_token", unique: true, using: :btree
  add_index "organisers", ["email"], name: "index_organisers_on_email", unique: true, using: :btree
  add_index "organisers", ["reset_password_token"], name: "index_organisers_on_reset_password_token", unique: true, using: :btree
  add_index "organisers", ["unlock_token"], name: "index_organisers_on_unlock_token", unique: true, using: :btree
  add_index "organisers", ["username"], name: "index_organisers_on_username", unique: true, using: :btree

  create_table "proposals", force: true do |t|
    t.text     "description",                 null: false
    t.integer  "price",                       null: false
    t.integer  "request_id",                  null: false
    t.integer  "vendor_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_winner",   default: false, null: false
  end

  add_index "proposals", ["request_id"], name: "index_proposals_on_request_id", using: :btree
  add_index "proposals", ["vendor_id"], name: "index_proposals_on_vendor_id", using: :btree

  create_table "requests", force: true do |t|
    t.string   "title",                           null: false
    t.string   "venue",                           null: false
    t.integer  "hours",                           null: false
    t.integer  "budget",                          null: false
    t.integer  "guests",                          null: false
    t.date     "date",                            null: false
    t.time     "time",                            null: false
    t.text     "description",                     null: false
    t.integer  "organiser_id",                    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "city_id"
    t.integer  "category_id",                     null: false
    t.boolean  "accept_proposal", default: true,  null: false
    t.boolean  "vendor_select",   default: false, null: false
    t.boolean  "cancel",          default: false, null: false
  end

  add_index "requests", ["category_id"], name: "index_requests_on_category_id", using: :btree
  add_index "requests", ["city_id"], name: "index_requests_on_city_id", using: :btree
  add_index "requests", ["organiser_id"], name: "index_requests_on_organiser_id", using: :btree

  create_table "vendor_profiles", force: true do |t|
    t.text     "about"
    t.string   "skills"
    t.string   "youtubelink"
    t.integer  "vendor_id",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic1_file_name"
    t.string   "pic1_content_type"
    t.integer  "pic1_file_size"
    t.datetime "pic1_updated_at"
    t.string   "pic2_file_name"
    t.string   "pic2_content_type"
    t.integer  "pic2_file_size"
    t.datetime "pic2_updated_at"
    t.string   "pic3_file_name"
    t.string   "pic3_content_type"
    t.integer  "pic3_file_size"
    t.datetime "pic3_updated_at"
    t.string   "pic4_file_name"
    t.string   "pic4_content_type"
    t.integer  "pic4_file_size"
    t.datetime "pic4_updated_at"
  end

  create_table "vendor_reviews", force: true do |t|
    t.string   "request_title",                       null: false
    t.string   "request_venue",                       null: false
    t.string   "organiser",                           null: false
    t.date     "date",                                null: false
    t.integer  "quality",       limit: 1, default: 0, null: false
    t.integer  "service",       limit: 1, default: 0, null: false
    t.integer  "vendor_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment",                             null: false
  end

  add_index "vendor_reviews", ["vendor_id"], name: "index_vendor_reviews_on_vendor_id", using: :btree

  create_table "vendors", force: true do |t|
    t.string   "email",                             default: "",   null: false
    t.string   "encrypted_password",                default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                                       null: false
    t.string   "last_name",                                        null: false
    t.string   "mobile",                 limit: 17,                null: false
    t.string   "business_name",                                    null: false
    t.integer  "est_year",               limit: 2,                 null: false
    t.string   "username",               limit: 25,                null: false
    t.integer  "city_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "category_id",                                      null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",                   default: 0,    null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.boolean  "approved",                          default: true, null: false
  end

  add_index "vendors", ["approved"], name: "index_vendors_on_approved", using: :btree
  add_index "vendors", ["category_id"], name: "index_vendors_on_category_id", using: :btree
  add_index "vendors", ["city_id"], name: "index_vendors_on_city_id", using: :btree
  add_index "vendors", ["confirmation_token"], name: "index_vendors_on_confirmation_token", unique: true, using: :btree
  add_index "vendors", ["email"], name: "index_vendors_on_email", unique: true, using: :btree
  add_index "vendors", ["reset_password_token"], name: "index_vendors_on_reset_password_token", unique: true, using: :btree
  add_index "vendors", ["unlock_token"], name: "index_vendors_on_unlock_token", unique: true, using: :btree
  add_index "vendors", ["username"], name: "index_vendors_on_username", unique: true, using: :btree

end
