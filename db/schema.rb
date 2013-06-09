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

ActiveRecord::Schema.define(version: 20130607173221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adobe_products", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "mnemonic_file_name"
    t.string   "mnemonic_content_type"
    t.integer  "mnemonic_file_size"
    t.datetime "mnemonic_updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "theme_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tools", force: true do |t|
    t.integer  "user_id"
    t.integer  "adobe_product_id"
    t.integer  "skill_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_applications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "mobile_phone"
    t.string   "gender",                     limit: 1
    t.string   "street_address"
    t.string   "street_address2"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "planned_grad_year"
    t.string   "planned_grad_term"
    t.string   "major"
    t.string   "minor"
    t.float    "gpa"
    t.integer  "num_facebook_friends"
    t.integer  "num_instagram_followers"
    t.integer  "num_twitter_followers"
    t.string   "other_social_sites"
    t.string   "member_design_community"
    t.string   "portfolio_url"
    t.text     "extracurriculars"
    t.boolean  "extracurricular_leadership"
    t.text     "leadership_description"
    t.string   "reference_name"
    t.string   "reference_relationship"
    t.string   "reference_email"
    t.string   "reference_phone"
    t.text     "how_adobe_helps"
    t.text     "student_orgs_and_leverage"
    t.text     "teaching_experience"
    t.text     "what_sets_you_apart"
    t.string   "do_you_have_time",           limit: 1
    t.string   "available_to_work",          limit: 1
    t.string   "video_submission_ulr"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                  default: false
    t.string   "authentication_token"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "suspended",              default: false
    t.integer  "program_admin_id"
    t.integer  "school_id"
    t.integer  "points"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
