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

ActiveRecord::Schema.define(version: 2019_02_10_125611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string "code"
    t.bigint "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["panel_provider_id"], name: "index_countries_on_panel_provider_id"
  end

  create_table "countries_target_groups", force: :cascade do |t|
    t.bigint "target_group_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_countries_target_groups_on_country_id"
    t.index ["target_group_id", "country_id"], name: "index_countries_target_groups_on_target_group_id_and_country_id", unique: true
    t.index ["target_group_id"], name: "index_countries_target_groups_on_target_group_id"
  end

  create_table "location_groups", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "country_id"
    t.bigint "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "location_id", null: false
    t.index ["country_id"], name: "index_location_groups_on_country_id"
    t.index ["location_id"], name: "index_location_groups_on_location_id"
    t.index ["panel_provider_id"], name: "index_location_groups_on_panel_provider_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", null: false
    t.uuid "external_id"
    t.string "secret_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secret_code_iv"
    t.index ["secret_code_iv"], name: "index_locations_on_secret_code_iv", unique: true
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.bigint "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.bigint "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "panel_providers", force: :cascade do |t|
    t.string "code", null: false
    t.string "type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_groups", force: :cascade do |t|
    t.string "name", null: false
    t.uuid "external_id"
    t.string "parent_id"
    t.string "secret_code"
    t.bigint "panel_provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secret_code_iv"
    t.index ["panel_provider_id"], name: "index_target_groups_on_panel_provider_id"
    t.index ["secret_code_iv"], name: "index_target_groups_on_secret_code_iv", unique: true
  end

  add_foreign_key "countries", "panel_providers"
  add_foreign_key "countries_target_groups", "countries"
  add_foreign_key "countries_target_groups", "target_groups"
  add_foreign_key "location_groups", "countries"
  add_foreign_key "location_groups", "panel_providers"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "target_groups", "panel_providers"
end
