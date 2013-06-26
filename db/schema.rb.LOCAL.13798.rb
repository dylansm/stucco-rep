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

ActiveRecord::Schema.define(version: 20130625201403) do

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

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.integer  "user_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "body"
    t.string   "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "program_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.string   "program_icon_file_name"
    t.string   "program_icon_content_type"
    t.integer  "program_icon_file_size"
    t.datetime "program_icon_updated_at"
    t.string   "theme_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs_schools", force: true do |t|
    t.integer  "program_id"
    t.integer  "school_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs_users", force: true do |t|
    t.integer "program_id"
    t.integer "user_id"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school_logo_file_name"
    t.string   "school_logo_content_type"
    t.integer  "school_logo_file_size"
    t.datetime "school_logo_updated_at"
    t.string   "name"
  end

  create_table "tools", force: true do |t|
    t.integer  "user_id"
    t.integer  "adobe_product_id"
    t.string   "name"
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
    t.text     "bio"
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
    t.string   "instagram_username"
    t.integer  "num_instagram_followers"
    t.string   "twitter_username"
    t.integer  "num_twitter_followers"
    t.string   "other_social_sites"
    t.string   "member_design_community"
    t.string   "portfolio_url"
    t.string   "behance_profile_url"
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
    t.string   "video_submission_url"
    t.string   "resume_file_name"
    t.string   "resume_content_type"
    t.integer  "resume_file_size"
    t.datetime "resume_updated_at"
  end

  add_index "user_applications", ["user_id"], name: "index_user_applications_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                     default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin",                     default: false
    t.string   "authentication_token"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "active_for_authentication", default: true
    t.integer  "school_id"
    t.integer  "program_id"
    t.integer  "points"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["program_id"], name: "index_users_on_program_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["school_id"], name: "index_users_on_school_id", using: :btree

end
