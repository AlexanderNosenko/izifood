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

ActiveRecord::Schema.define(version: 20170724132921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "ingredients", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price_piece", default: -1.0, null: false
    t.float "price_volume", default: -1.0
    t.string "quantifier", default: "-kg", null: false
    t.string "image"
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
    t.index ["deliver_on"], name: "index_menus_on_deliver_on"
    t.index ["main"], name: "index_menus_on_main"
    t.index ["recurring"], name: "index_menus_on_recurring"
    t.index ["title"], name: "index_menus_on_title"
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.string "quantity"
    t.bigint "order_id"
    t.bigint "ingredient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_order_items_on_ingredient_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "menu_id"
    t.datetime "deliver_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deliver_on"], name: "index_orders_on_deliver_on"
    t.index ["menu_id"], name: "index_orders_on_menu_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "recipe_ingredients", force: :cascade do |t|
    t.bigint "ingredient_id"
    t.bigint "recipe_id"
    t.string "quantity", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_recipe_ingredients_on_ingredient_id"
    t.index ["recipe_id"], name: "index_recipe_ingredients_on_recipe_id"
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
  add_foreign_key "orders", "menus"
  add_foreign_key "orders", "users"
end
