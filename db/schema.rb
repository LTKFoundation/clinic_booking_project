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

ActiveRecord::Schema.define(version: 20161125151545) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "unaccent"

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_admins_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "start_at",     null: false
    t.decimal  "price",        null: false
    t.decimal  "deposit",      null: false
    t.string   "status",       null: false
    t.string   "session_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "cart_id"
    t.integer  "gig_id"
    t.string   "confirm_code"
    t.integer  "patient_id"
    t.index ["cart_id"], name: "index_bookings_on_cart_id", using: :btree
    t.index ["gig_id"], name: "index_bookings_on_gig_id", using: :btree
    t.index ["patient_id"], name: "index_bookings_on_patient_id", using: :btree
    t.index ["user_id"], name: "index_bookings_on_user_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "session_id"
    t.integer  "user_id"
    t.datetime "paid_at"
    t.integer  "grand_total"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_carts_on_user_id", using: :btree
  end

  create_table "clinics", force: :cascade do |t|
    t.integer  "doctor_id"
    t.string   "name",        null: false
    t.string   "address",     null: false
    t.float    "latitude"
    t.string   "license"
    t.string   "phone"
    t.string   "photos"
    t.string   "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.float    "longtitude"
    t.datetime "verified_at"
    t.index ["doctor_id"], name: "index_clinics_on_doctor_id", using: :btree
  end

  create_table "doctor_comments", force: :cascade do |t|
    t.integer  "doctor_rating_id"
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.string   "content"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "rate"
    t.string   "title"
    t.index ["doctor_id"], name: "index_doctor_comments_on_doctor_id", using: :btree
    t.index ["doctor_rating_id"], name: "index_doctor_comments_on_doctor_rating_id", using: :btree
    t.index ["user_id"], name: "index_doctor_comments_on_user_id", using: :btree
  end

  create_table "doctor_ratings", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.integer  "booking_id"
    t.integer  "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_doctor_ratings_on_booking_id", using: :btree
    t.index ["doctor_id"], name: "index_doctor_ratings_on_doctor_id", using: :btree
    t.index ["user_id"], name: "index_doctor_ratings_on_user_id", using: :btree
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "name",                                     null: false
    t.string   "phone"
    t.string   "expertise"
    t.string   "avatar"
    t.string   "description"
    t.string   "certificate"
    t.datetime "verified_at"
    t.string   "provider",               default: "email", null: false
    t.string   "uid"
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "title"
    t.index ["email"], name: "index_doctors_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true, using: :btree
  end

  create_table "gigs", force: :cascade do |t|
    t.integer  "doctor_id"
    t.integer  "clinic_id"
    t.decimal  "price",            precision: 12, scale: 2
    t.decimal  "deposit",          precision: 12, scale: 2
    t.integer  "checkup_duration"
    t.integer  "margin_duration"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.index ["clinic_id"], name: "index_gigs_on_clinic_id", using: :btree
    t.index ["doctor_id"], name: "index_gigs_on_doctor_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "BloodType"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.string   "name",       null: false
    t.datetime "dob",        null: false
    t.string   "gender",     null: false
    t.string   "address",    null: false
    t.index ["doctor_id"], name: "index_patients_on_doctor_id", using: :btree
    t.index ["user_id"], name: "index_patients_on_user_id", using: :btree
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

  create_table "schedules", force: :cascade do |t|
    t.integer  "gig_id"
    t.text     "start_at"
    t.text     "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "weekday"
    t.index ["gig_id"], name: "index_schedules_on_gig_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "",      null: false
    t.string   "phone"
    t.string   "gender"
    t.date     "dob"
    t.string   "avatar"
    t.string   "address"
    t.string   "provider",               default: "email", null: false
    t.string   "uid"
    t.string   "email",                  default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "bookings", "carts"
  add_foreign_key "bookings", "gigs"
  add_foreign_key "bookings", "patients"
  add_foreign_key "bookings", "users"
  add_foreign_key "doctor_comments", "doctor_ratings"
  add_foreign_key "doctor_comments", "doctors"
  add_foreign_key "doctor_comments", "users"
  add_foreign_key "doctor_ratings", "bookings"
  add_foreign_key "doctor_ratings", "doctors"
  add_foreign_key "doctor_ratings", "users"
  add_foreign_key "gigs", "clinics"
  add_foreign_key "gigs", "doctors"
  add_foreign_key "patients", "doctors"
  add_foreign_key "patients", "users"
  add_foreign_key "payment_methods", "users"
  add_foreign_key "schedules", "gigs"
end
