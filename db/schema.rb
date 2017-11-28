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

ActiveRecord::Schema.define(version: 20171127160632) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "uuid-ossp"

  create_table "deliveries", force: :cascade do |t|
    t.date "deliver_on", null: false
    t.decimal "cost_value", precision: 5, scale: 2, null: false
    t.string "cost_currency", null: false
    t.string "time_from", null: false
    t.string "time_to", null: false
    t.bigint "order_id", null: false
    t.bigint "delivery_address_id", null: false
    t.index ["deliver_on"], name: "index_deliveries_on_deliver_on"
    t.index ["delivery_address_id"], name: "index_deliveries_on_delivery_address_id"
    t.index ["order_id"], name: "index_deliveries_on_order_id"
  end

  create_table "delivery_addresses", force: :cascade do |t|
    t.string "title", default: "Home 1"
    t.string "address", null: false
    t.string "flat_number", null: false
    t.jsonb "details", null: false
    t.boolean "default", default: false, null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_delivery_addresses_on_user_id"
  end

  create_table "delivery_slots", force: :cascade do |t|
    t.text "content_html", null: false
    t.string "vendor", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }
  end

  create_table "ingredient_searches", force: :cascade do |t|
    t.string "search", null: false
    t.string "results", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["search"], name: "index_ingredient_searches_on_search", unique: true
  end

  create_table "ingredient_translations", force: :cascade do |t|
    t.bigint "ingredient_id", null: false
    t.string "label", null: false
    t.string "language", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_ingredient_translations_on_ingredient_id"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string "title", null: false
    t.float "price_piece", default: -1.0, null: false
    t.float "price_volume", default: -1.0
    t.string "quantifier", default: "-kg", null: false
    t.string "min_amount", null: false
    t.string "image"
    t.string "tesco_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_ingredients_on_title", unique: true
  end

  create_table "menu_recipes", force: :cascade do |t|
    t.bigint "menu_id"
    t.bigint "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_recipes_on_menu_id"
    t.index ["recipe_id"], name: "index_menu_recipes_on_recipe_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "title"
    t.boolean "recurring", default: false
    t.boolean "main", default: true, null: false
    t.datetime "deliver_on"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["deliver_on"], name: "index_menus_on_deliver_on"
    t.index ["main"], name: "index_menus_on_main"
    t.index ["recurring"], name: "index_menus_on_recurring"
    t.index ["title"], name: "index_menus_on_title"
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "recipe_ingredient_id", null: false
    t.bigint "order_id", null: false
    t.bigint "ingredient_id", null: false
    t.string "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_order_items_on_ingredient_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["recipe_ingredient_id"], name: "index_order_items_on_recipe_ingredient_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "menu_id"
    t.datetime "deliver_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["deliver_on"], name: "index_orders_on_deliver_on"
    t.index ["menu_id"], name: "index_orders_on_menu_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.decimal "amount", precision: 5, scale: 2, null: false
    t.bigint "user_id", null: false
    t.integer "_type", default: 0, null: false
    t.integer "status", default: 0, null: false
    t.jsonb "info", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["_type"], name: "index_payments_on__type"
    t.index ["info"], name: "index_payments_on_info"
    t.index ["status"], name: "index_payments_on_status"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "promotions", force: :cascade do |t|
    t.integer "_type", default: 0, null: false
    t.integer "for", default: 0, null: false
    t.jsonb "info", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["_type"], name: "index_promotions_on__type"
    t.index ["for"], name: "index_promotions_on_for"
    t.index ["info"], name: "index_promotions_on_info"
  end

  create_table "quantity_matches", force: :cascade do |t|
    t.string "key"
    t.string "value"
    t.string "quantifier"
    t.bigint "origin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_quantity_matches_on_key", unique: true
    t.index ["origin_id"], name: "index_quantity_matches_on_origin_id"
    t.index ["quantifier"], name: "index_quantity_matches_on_quantifier"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "recipe_id"
    t.string "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title", default: "", null: false
    t.integer "match", default: 0, null: false
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
  end

  create_table "recipe_tags", force: :cascade do |t|
    t.string "title", null: false
    t.integer "_type", default: 0, null: false
    t.string "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title", "_type"], name: "index_recipe_tags_on_title_and__type", unique: true
  end

  create_table "recipes", force: :cascade do |t|
    t.string "title", null: false
    t.string "images", default: [], null: false, array: true
    t.text "description", default: [], null: false, array: true
    t.string "desc_images", default: [], array: true
    t.integer "r_type", default: 0, null: false
    t.integer "prep_time", default: 0, null: false
    t.integer "prep_type", default: 0, null: false
    t.integer "cost", default: 0, null: false
    t.integer "calories", default: 0, null: false
    t.integer "portion_size", default: 0, null: false
    t.integer "main_ingredient", default: 0, null: false
    t.integer "cuisine", default: 0, null: false
    t.boolean "veg", default: false, null: false
    t.boolean "grill", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["calories"], name: "index_recipes_on_calories"
    t.index ["cost"], name: "index_recipes_on_cost"
    t.index ["cuisine"], name: "index_recipes_on_cuisine"
    t.index ["grill"], name: "index_recipes_on_grill"
    t.index ["main_ingredient"], name: "index_recipes_on_main_ingredient"
    t.index ["portion_size"], name: "index_recipes_on_portion_size"
    t.index ["prep_time"], name: "index_recipes_on_prep_time"
    t.index ["prep_type"], name: "index_recipes_on_prep_type"
    t.index ["r_type"], name: "index_recipes_on_r_type"
    t.index ["veg"], name: "index_recipes_on_veg"
  end

  create_table "recipes_tags", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recipe_id", "tag_id"], name: "index_recipes_tags_on_recipe_id_and_tag_id", unique: true
    t.index ["recipe_id"], name: "index_recipes_tags_on_recipe_id"
    t.index ["tag_id"], name: "index_recipes_tags_on_tag_id"
  end

  create_table "search_duplicates", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "origin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["origin_id"], name: "index_search_duplicates_on_origin_id"
    t.index ["value"], name: "index_search_duplicates_on_value", unique: true
  end

  create_table "user_promotions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "promotion_id", null: false
    t.jsonb "info", default: {}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["info"], name: "index_user_promotions_on_info"
    t.index ["promotion_id"], name: "index_user_promotions_on_promotion_id"
    t.index ["user_id"], name: "index_user_promotions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "menu_recipes", "menus"
  add_foreign_key "menu_recipes", "recipes"
  add_foreign_key "menus", "users"
  add_foreign_key "order_items", "ingredients"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "recipe_ingredients"
  add_foreign_key "orders", "menus"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "users"
  add_foreign_key "quantity_matches", "quantity_matches", column: "origin_id"
  add_foreign_key "search_duplicates", "ingredient_searches", column: "origin_id"
  add_foreign_key "user_promotions", "promotions"
  add_foreign_key "user_promotions", "users"
end
