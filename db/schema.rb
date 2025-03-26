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

ActiveRecord::Schema[8.0].define(version: 2025_03_26_113447) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "pgcrypto"

  create_table "answers", force: :cascade do |t|
    t.bigint "assessment_id", null: false
    t.bigint "question_id", null: false
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_answers_on_assessment_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
  end

  create_table "assessments", force: :cascade do |t|
    t.uuid "patient_id", null: false
    t.date "completed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["patient_id"], name: "index_assessments_on_patient_id"
    t.index ["user_id"], name: "index_assessments_on_user_id"
  end

  create_table "diagnostic_screener_instances", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.uuid "patient_id"
    t.uuid "diagnostic_screener_template_id"
    t.datetime "completed_at"
    t.index ["diagnostic_screener_template_id"], name: "idx_on_diagnostic_screener_template_id_bfd87c59a5"
    t.index ["patient_id"], name: "index_diagnostic_screener_instances_on_patient_id"
    t.index ["token"], name: "index_diagnostic_screener_instances_on_token", unique: true
    t.index ["user_id"], name: "index_diagnostic_screener_instances_on_user_id"
  end

  create_table "diagnostic_screener_results", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "diagnostic_screener_instance_id", null: false
    t.integer "score", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["diagnostic_screener_instance_id"], name: "idx_on_diagnostic_screener_instance_id_25400fa623"
  end

  create_table "diagnostic_screener_templates", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "disorder"
    t.string "display_name"
    t.string "full_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "domain_mappings", force: :cascade do |t|
    t.integer "domain"
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_domain_mappings_on_question_id"
  end

  create_table "patients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_patients_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "questionable_type", null: false
    t.bigint "questionable_id", null: false
    t.index ["questionable_type", "questionable_id"], name: "index_questions_on_questionable"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "answers", "assessments"
  add_foreign_key "answers", "questions"
  add_foreign_key "assessments", "patients"
  add_foreign_key "assessments", "users"
  add_foreign_key "diagnostic_screener_instances", "diagnostic_screener_templates"
  add_foreign_key "diagnostic_screener_instances", "patients"
  add_foreign_key "diagnostic_screener_instances", "users"
  add_foreign_key "diagnostic_screener_results", "diagnostic_screener_instances"
  add_foreign_key "domain_mappings", "questions"
  add_foreign_key "patients", "users"
end
