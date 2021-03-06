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

ActiveRecord::Schema.define(version: 20161127122427) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.decimal  "amount",               precision: 12, scale: 2,                 null: false
    t.string   "currency",   limit: 3,                          default: "RUB", null: false
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "actions", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.date     "date"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "content"
    t.string   "link"
    t.string   "string"
    t.string   "event_type", default: "f", null: false
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "status"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "feedbacks", force: :cascade do |t|
    t.text     "name"
    t.text     "feedback"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "date"
  end

  create_table "galleries", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "cover"
    t.string   "token"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "materials", force: :cascade do |t|
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "order_id"
    t.integer  "status",                default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "materials", ["order_id"], name: "index_materials_on_order_id", using: :btree

  create_table "messages", force: :cascade do |t|
    t.integer  "sender_id",               null: false
    t.integer  "receiver_id",             null: false
    t.text     "content",                 null: false
    t.integer  "status",      default: 0
    t.integer  "order_id",                null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "messages", ["order_id"], name: "index_messages_on_order_id", using: :btree

  create_table "news", force: :cascade do |t|
    t.text     "title"
    t.text     "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.date     "date"
  end

  create_table "orders", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "worktype_id"
    t.string   "worktype_other"
    t.integer  "speciality_id"
    t.string   "speciality_other"
    t.string   "institution"
    t.string   "theme"
    t.string   "uniqueness"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.text     "comment"
    t.date     "deadline"
    t.integer  "page_number"
    t.integer  "manager_id"
    t.integer  "employee_id"
    t.datetime "employee_deadline"
    t.datetime "inform_date"
    t.integer  "status",                default: 0
    t.integer  "price"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.integer  "employee_price"
    t.string   "commentary"
    t.string   "note"
    t.integer  "subspeciality_id"
  end

  add_index "orders", ["speciality_id"], name: "index_orders_on_speciality_id", using: :btree
  add_index "orders", ["subspeciality_id"], name: "index_orders_on_subspeciality_id", using: :btree
  add_index "orders", ["worktype_id"], name: "index_orders_on_worktype_id", using: :btree

  create_table "parts", force: :cascade do |t|
    t.string   "name"
    t.datetime "deadline"
    t.integer  "order_id"
    t.text     "description"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "status",            default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "parts", ["order_id"], name: "index_parts_on_order_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "client_id",                                                             null: false
    t.decimal  "amount",                       precision: 12, scale: 2,                 null: false
    t.string   "currency",           limit: 3,                          default: "RUB", null: false
    t.datetime "expires",                                                               null: false
    t.integer  "status",                                                default: 0,     null: false
    t.string   "check_file_name"
    t.string   "check_content_type"
    t.integer  "check_file_size"
    t.datetime "check_updated_at"
    t.string   "sys_id"
    t.datetime "sys_date"
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
    t.string   "details"
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id", using: :btree

  create_table "payouts", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "employee_id",                                                    null: false
    t.decimal  "amount",                precision: 12, scale: 2,                 null: false
    t.string   "currency",    limit: 3,                          default: "RUB", null: false
    t.integer  "status",                                         default: 0,     null: false
    t.datetime "sys_date"
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
    t.string   "details"
  end

  add_index "payouts", ["order_id"], name: "index_payouts_on_order_id", using: :btree

  create_table "pictures", force: :cascade do |t|
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "gallery_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "pictures", ["gallery_id"], name: "index_pictures_on_gallery_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "question"
    t.text     "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date     "date"
  end

  create_table "revisions", force: :cascade do |t|
    t.text     "comment"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "order_id"
    t.integer  "status",                default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "revisions", ["order_id"], name: "index_revisions_on_order_id", using: :btree

  create_table "seos", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "title"
    t.string   "code_title"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "specialities", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specialities_users", id: false, force: :cascade do |t|
    t.integer "employee_id"
    t.integer "speciality_id"
  end

  add_index "specialities_users", ["employee_id", "speciality_id"], name: "index_specialities_users_on_employee_id_and_speciality_id", unique: true, using: :btree
  add_index "specialities_users", ["employee_id"], name: "index_specialities_users_on_employee_id", using: :btree
  add_index "specialities_users", ["speciality_id"], name: "index_specialities_users_on_speciality_id", using: :btree

  create_table "statics", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.date     "date"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "subspecialities", force: :cascade do |t|
    t.text     "subspeciality"
    t.integer  "speciality_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "subspecialities", ["speciality_id"], name: "index_subspecialities_on_speciality_id", using: :btree

  create_table "subspecialities_users", id: false, force: :cascade do |t|
    t.integer "employee_id"
    t.integer "subspeciality_id"
  end

  add_index "subspecialities_users", ["employee_id", "subspeciality_id"], name: "index_subspecialities_users_on_employee_id_and_subspeciality_id", unique: true, using: :btree
  add_index "subspecialities_users", ["employee_id"], name: "index_subspecialities_users_on_employee_id", using: :btree
  add_index "subspecialities_users", ["subspeciality_id"], name: "index_subspecialities_users_on_subspeciality_id", using: :btree

  create_table "tforms", force: :cascade do |t|
    t.string   "name"
    t.string   "city"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "name"
    t.string   "phone"
    t.string   "skype"
    t.string   "city"
    t.string   "role"
    t.boolean  "activated",              default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "worktypes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.text     "description"
    t.boolean  "show"
    t.string   "title"
    t.string   "mdescription"
    t.text     "price"
    t.text     "terms"
    t.integer  "order"
    t.string   "descr"
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "events", "users"
  add_foreign_key "materials", "orders"
  add_foreign_key "messages", "orders"
  add_foreign_key "messages", "users", column: "receiver_id"
  add_foreign_key "messages", "users", column: "sender_id"
  add_foreign_key "orders", "specialities"
  add_foreign_key "orders", "users", column: "client_id"
  add_foreign_key "orders", "users", column: "employee_id"
  add_foreign_key "orders", "users", column: "manager_id"
  add_foreign_key "orders", "worktypes"
  add_foreign_key "parts", "orders"
  add_foreign_key "payments", "orders"
  add_foreign_key "payouts", "orders"
  add_foreign_key "pictures", "galleries"
  add_foreign_key "revisions", "orders"
  add_foreign_key "subspecialities", "specialities"
end
