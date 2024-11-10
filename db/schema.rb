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

ActiveRecord::Schema[7.1].define(version: 2024_11_10_183030) do
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

  create_table "dish_menus", force: :cascade do |t|
    t.integer "dish_id", null: false
    t.integer "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_menus_on_dish_id"
    t.index ["menu_id"], name: "index_dish_menus_on_menu_id"
  end

  create_table "dish_options", force: :cascade do |t|
    t.integer "dish_id", null: false
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_options_on_dish_id"
  end

  create_table "dish_tags", force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "dish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dish_id"], name: "index_dish_tags_on_dish_id"
    t.index ["tag_id"], name: "index_dish_tags_on_tag_id"
  end

  create_table "dishes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "calories"
    t.string "image"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["establishment_id"], name: "index_dishes_on_establishment_id"
  end

  create_table "drink_menus", force: :cascade do |t|
    t.integer "drink_id", null: false
    t.integer "menu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_drink_menus_on_drink_id"
    t.index ["menu_id"], name: "index_drink_menus_on_menu_id"
  end

  create_table "drink_options", force: :cascade do |t|
    t.integer "drink_id", null: false
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_drink_options_on_drink_id"
  end

  create_table "drinks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "calories"
    t.string "image"
    t.integer "is_alcoholic"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["establishment_id"], name: "index_drinks_on_establishment_id"
  end

  create_table "establishments", force: :cascade do |t|
    t.string "corporate_name"
    t.string "brand_name"
    t.string "cnpj"
    t.string "address"
    t.string "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "phone_number"
    t.string "email"
    t.string "code"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_establishments_on_user_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_menus_on_establishment_id"
  end

  create_table "operating_hours", force: :cascade do |t|
    t.integer "day_of_week"
    t.time "opening_time"
    t.time "closing_time"
    t.integer "status", default: 0
    t.integer "establishment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_operating_hours_on_establishment_id"
  end

  create_table "order_dishes", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "dish_id", null: false
    t.string "observation"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "dish_option_id", null: false
    t.index ["dish_id"], name: "index_order_dishes_on_dish_id"
    t.index ["dish_option_id"], name: "index_order_dishes_on_dish_option_id"
    t.index ["order_id"], name: "index_order_dishes_on_order_id"
  end

  create_table "order_drinks", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "drink_id", null: false
    t.string "observation"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "drink_option_id", null: false
    t.index ["drink_id"], name: "index_order_drinks_on_drink_id"
    t.index ["drink_option_id"], name: "index_order_drinks_on_drink_option_id"
    t.index ["order_id"], name: "index_order_drinks_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "establishment_id", null: false
    t.string "customer_name"
    t.string "customer_cpf"
    t.string "customer_email"
    t.string "customer_phone"
    t.decimal "total_value", precision: 8, scale: 2
    t.string "code"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_orders_on_establishment_id"
  end

  create_table "pre_registrations", force: :cascade do |t|
    t.integer "establishment_id", null: false
    t.string "email"
    t.string "cpf"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["establishment_id"], name: "index_pre_registrations_on_establishment_id"
  end

  create_table "price_histories", force: :cascade do |t|
    t.decimal "price", precision: 8, scale: 2
    t.integer "item_type"
    t.integer "item_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.index ["item_type", "item_id"], name: "index_price_histories_on_item_type_and_item_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.string "last_name"
    t.string "identification_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dish_menus", "dishes"
  add_foreign_key "dish_menus", "menus"
  add_foreign_key "dish_options", "dishes"
  add_foreign_key "dish_tags", "dishes"
  add_foreign_key "dish_tags", "tags"
  add_foreign_key "dishes", "establishments"
  add_foreign_key "drink_menus", "drinks"
  add_foreign_key "drink_menus", "menus"
  add_foreign_key "drink_options", "drinks"
  add_foreign_key "drinks", "establishments"
  add_foreign_key "establishments", "users"
  add_foreign_key "menus", "establishments"
  add_foreign_key "operating_hours", "establishments"
  add_foreign_key "order_dishes", "dish_options"
  add_foreign_key "order_dishes", "dishes"
  add_foreign_key "order_dishes", "orders"
  add_foreign_key "order_drinks", "drink_options"
  add_foreign_key "order_drinks", "drinks"
  add_foreign_key "order_drinks", "orders"
  add_foreign_key "orders", "establishments"
  add_foreign_key "pre_registrations", "establishments"
end
