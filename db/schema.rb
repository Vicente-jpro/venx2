# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_04_101310) do
  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.integer "city_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_addresses_on_city_id"
  end

  create_table "cart_historics", force: :cascade do |t|
    t.integer "quantity"
    t.boolean "abandoned", default: false
    t.string "code_cart"
    t.integer "profile_id", null: false
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_cart_historics_on_item_id"
    t.index ["profile_id"], name: "index_cart_historics_on_profile_id"
  end

  create_table "cart_saveds", force: :cascade do |t|
    t.integer "quantity"
    t.boolean "abandoned", default: true
    t.string "code_cart"
    t.integer "item_id", null: false
    t.integer "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_cart_saveds_on_item_id"
    t.index ["profile_id"], name: "index_cart_saveds_on_profile_id"
  end

  create_table "cart_temps", force: :cascade do |t|
    t.integer "quantity"
    t.boolean "abandoned", default: true
    t.integer "item_id", null: false
    t.integer "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_cart_temps_on_item_id"
    t.index ["profile_id"], name: "index_cart_temps_on_profile_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name_category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.string "city_name"
    t.integer "province_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_cities_on_province_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "whatsapp"
    t.string "telephone"
    t.string "email"
    t.string "nif"
    t.integer "address_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_companies_on_address_id"
  end

  create_table "invoice_historics", force: :cascade do |t|
    t.string "cliente_name"
    t.decimal "total"
    t.decimal "sub_total"
    t.decimal "value_delivered_customer"
    t.decimal "customer_change"
    t.string "payment_method"
    t.integer "profile_id", null: false
    t.integer "cart_historic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_historic_id"], name: "index_invoice_historics_on_cart_historic_id"
    t.index ["profile_id"], name: "index_invoice_historics_on_profile_id"
  end

  create_table "invoice_temps", force: :cascade do |t|
    t.string "cliente_name"
    t.decimal "total"
    t.decimal "sub_total"
    t.decimal "value_delivered_customer"
    t.decimal "customer_change"
    t.string "payment_method"
    t.integer "profile_id", null: false
    t.integer "cart_historic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cart_historic_id"], name: "index_invoice_temps_on_cart_historic_id"
    t.index ["profile_id"], name: "index_invoice_temps_on_profile_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "description"
    t.date "manufacturing_date"
    t.date "expiration_date"
    t.integer "quantity"
    t.decimal "price"
    t.string "item_code"
    t.decimal "profite_value"
    t.integer "supplier_id", null: false
    t.integer "category_id", null: false
    t.integer "profile_id", null: false
    t.integer "sector_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_items_on_category_id"
    t.index ["profile_id"], name: "index_items_on_profile_id"
    t.index ["sector_id"], name: "index_items_on_sector_id"
    t.index ["supplier_id"], name: "index_items_on_supplier_id"
  end

  create_table "most_sales", force: :cascade do |t|
    t.integer "quantity"
    t.integer "item_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_most_sales_on_item_id"
  end

  create_table "plans", force: :cascade do |t|
    t.date "sign_date"
    t.date "expiration_date"
    t.integer "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_plans_on_company_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name_profile"
    t.string "whatsapp"
    t.string "telephone"
    t.string "identity_card"
    t.string "profile_type"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "address_id", null: false
    t.string "gender"
    t.integer "company_id", default: 1, null: false
    t.index ["address_id"], name: "index_profiles_on_address_id"
    t.index ["company_id"], name: "index_profiles_on_company_id"
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "province_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name_sector"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name_supplier"
    t.string "whatsapp"
    t.string "telephone"
    t.string "email"
    t.integer "address_id", null: false
    t.integer "profile_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_suppliers_on_address_id"
    t.index ["profile_id"], name: "index_suppliers_on_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "cities"
  add_foreign_key "cart_historics", "items"
  add_foreign_key "cart_historics", "profiles"
  add_foreign_key "cart_saveds", "items"
  add_foreign_key "cart_saveds", "profiles"
  add_foreign_key "cart_temps", "items"
  add_foreign_key "cart_temps", "profiles"
  add_foreign_key "cities", "provinces"
  add_foreign_key "companies", "addresses"
  add_foreign_key "invoice_historics", "cart_historics"
  add_foreign_key "invoice_historics", "profiles"
  add_foreign_key "invoice_temps", "cart_historics"
  add_foreign_key "invoice_temps", "profiles"
  add_foreign_key "items", "categories"
  add_foreign_key "items", "profiles"
  add_foreign_key "items", "sectors"
  add_foreign_key "items", "suppliers"
  add_foreign_key "most_sales", "items"
  add_foreign_key "plans", "companies"
  add_foreign_key "profiles", "addresses"
  add_foreign_key "profiles", "companies"
  add_foreign_key "profiles", "users"
  add_foreign_key "suppliers", "addresses"
  add_foreign_key "suppliers", "profiles"
end
