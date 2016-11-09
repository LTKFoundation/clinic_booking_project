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

ActiveRecord::Schema.define(version: 20161109182623) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clinics", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "address",    null: false
    t.float    "latitude"
    t.string   "license"
    t.string   "phone"
    t.string   "photos"
    t.string   "position"
    t.integer  "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_clinics_on_doctor_id", using: :btree
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "avatar"
    t.string   "expertise"
    t.string   "description"
    t.string   "certificate"
    t.date     "verified_at"
    t.integer  "clinic_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["clinic_id"], name: "index_doctors_on_clinic_id", using: :btree
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "cc_no"
    t.string   "ccv_no"
    t.date     "valid_until"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_payment_methods_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "",       null: false
    t.string   "phone"
    t.string   "gender"
    t.date     "dob"
    t.string   "avatar"
    t.string   "provider",               default: "email",  null: false
    t.string   "uid"
    t.string   "type",                   default: "client", null: false
    t.string   "email",                  default: "",       null: false
    t.string   "encrypted_password",     default: "",       null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,        null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "doctors", "clinics", on_delete: :cascade
  add_foreign_key "payment_methods", "users"
end
