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

ActiveRecord::Schema[8.0].define(version: 2025_03_02_174418) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", comment: "Account name"
    t.decimal "amount", precision: 15, scale: 2, default: "0.0", comment: "Account balance"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", comment: "The category name, for example Investment, Health..."
  end

  create_table "operations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id", null: false, comment: "Related account"
    t.string "kind", comment: "Operation kind, an enum with values (spend, earning, investment)"
    t.decimal "value", precision: 15, scale: 2, comment: "Monetary value of the operation"
    t.text "description", comment: "Operation description"
    t.date "date", comment: "When the operation happend"
    t.string "payment_method", comment: "A enum backed by a string that defines the operation payment method."
    t.index ["account_id"], name: "index_operations_on_account_id"
  end

  add_foreign_key "operations", "accounts"
end
