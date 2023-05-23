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

ActiveRecord::Schema.define(version: 2023_05_23_025534) do

  create_table "activity_histories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "record_type"
    t.bigint "record_id"
    t.integer "action", null: false
    t.date "date"
    t.text "description"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id"], name: "index_activity_histories_on_record_type_and_record_id"
    t.index ["user_id"], name: "index_activity_histories_on_user_id"
  end

  create_table "affiliated_rols", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true
    t.bigint "province_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["province_id"], name: "index_cities_on_province_id"
  end

  create_table "dni_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_dni_types_on_name", unique: true
  end

  create_table "headquarter_affiliateds", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "headquarter_id"
    t.bigint "person_id"
    t.bigint "affiliated_rol_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["affiliated_rol_id"], name: "index_headquarter_affiliateds_on_affiliated_rol_id"
    t.index ["headquarter_id"], name: "index_headquarter_affiliateds_on_headquarter_id"
    t.index ["person_id"], name: "index_headquarter_affiliateds_on_person_id"
  end

  create_table "headquarters", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "neighborhood_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["neighborhood_id"], name: "index_headquarters_on_neighborhood_id"
  end

  create_table "institution_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "institutions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "direction", null: false
    t.boolean "active", default: true
    t.bigint "neighborhood_id"
    t.bigint "institution_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_type_id"], name: "index_institutions_on_institution_type_id"
    t.index ["neighborhood_id"], name: "index_institutions_on_neighborhood_id"
  end

  create_table "neighborhoods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_neighborhoods_on_city_id"
  end

  create_table "people", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "last_name", null: false
    t.integer "genre", null: false
    t.bigint "dni"
    t.integer "number", null: false
    t.string "direction"
    t.boolean "active", default: true
    t.bigint "neighborhood_id"
    t.bigint "dni_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dni_type_id"], name: "index_people_on_dni_type_id"
    t.index ["neighborhood_id"], name: "index_people_on_neighborhood_id"
  end

  create_table "political_parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "politician_rols", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "politicians_parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "politician", null: false
    t.bigint "political_party_id"
    t.bigint "politician_rol_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["political_party_id"], name: "index_politicians_parties_on_political_party_id"
    t.index ["politician_rol_id"], name: "index_politicians_parties_on_politician_rol_id"
  end

  create_table "provinces", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_provinces_on_name", unique: true
  end

  create_table "tables", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.integer "number", null: false
    t.integer "vouters"
    t.boolean "active", default: true
    t.bigint "institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_tables_on_institution_id"
  end

  create_table "tables_political_parties", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.bigint "table_id"
    t.bigint "political_party_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["political_party_id"], name: "index_tables_political_parties_on_political_party_id"
    t.index ["table_id"], name: "index_tables_political_parties_on_table_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "username", null: false
    t.string "email", null: false
    t.integer "rol", null: false
    t.string "password_digest", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "activity_histories", "users"
  add_foreign_key "cities", "provinces"
  add_foreign_key "headquarter_affiliateds", "affiliated_rols"
  add_foreign_key "headquarter_affiliateds", "headquarters"
  add_foreign_key "headquarter_affiliateds", "people"
  add_foreign_key "headquarters", "neighborhoods"
  add_foreign_key "institutions", "institution_types"
  add_foreign_key "institutions", "neighborhoods"
  add_foreign_key "neighborhoods", "cities"
  add_foreign_key "people", "dni_types"
  add_foreign_key "people", "neighborhoods"
  add_foreign_key "politicians_parties", "political_parties"
  add_foreign_key "politicians_parties", "politician_rols"
  add_foreign_key "tables", "institutions"
  add_foreign_key "tables_political_parties", "political_parties"
  add_foreign_key "tables_political_parties", "tables"
end
