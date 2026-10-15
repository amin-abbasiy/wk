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

ActiveRecord::Schema[7.1].define(version: 2025_04_14_162427) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.text "name"
    t.text "body"
    t.text "record_type"
    t.bigint "record_id"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.index ["record_type", "record_id", "name"], name: "idx_672009_index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.text "name"
    t.text "record_type"
    t.bigint "record_id"
    t.bigint "blob_id"
    t.timestamptz "created_at"
    t.index ["blob_id"], name: "idx_671910_index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "idx_671910_index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.text "key"
    t.text "filename"
    t.text "content_type"
    t.text "metadata"
    t.text "service_name"
    t.bigint "byte_size"
    t.text "checksum"
    t.timestamptz "created_at"
    t.index ["key"], name: "idx_671901_index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id"
    t.text "variation_digest"
    t.index ["blob_id", "variation_digest"], name: "idx_671919_index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "applications", force: :cascade do |t|
    t.text "company_name"
    t.text "position_title"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "status"
    t.text "job_description"
    t.text "feedback"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_applications_on_user_id"
  end

  create_table "auto_suggestions", force: :cascade do |t|
    t.text "idea"
    t.text "faith"
    t.text "plan"
    t.text "action"
    t.text "persistence"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_auto_suggestions_on_user_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.text "data_file_name"
    t.text "data_content_type"
    t.bigint "data_file_size"
    t.text "data_fingerprint"
    t.text "type"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.index ["type"], name: "idx_672036_index_ckeditor_assets_on_type"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "topic_id"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["topic_id"], name: "idx_671883_index_comments_on_topic_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "commets", force: :cascade do |t|
    t.text "content"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
  end

  create_table "email_messages", force: :cascade do |t|
    t.text "message"
    t.text "response"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_email_messages_on_user_id"
  end

  create_table "englishes", force: :cascade do |t|
    t.text "word"
    t.text "definition"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_englishes_on_user_id"
  end

  create_table "flashcards", force: :cascade do |t|
    t.text "content"
    t.text "description"
    t.bigint "status"
    t.bigint "repetition"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_flashcards_on_user_id"
  end

  create_table "frustrations", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.text "trash_them"
    t.text "reasons"
    t.text "channeling_techniques"
    t.text "created_purposes"
    t.text "goals_for_purposes"
    t.text "action_plan"
    t.text "emotions_after_action"
    t.text "result_of_emotions"
    t.text "resule_of_action"
    t.text "catchphrase"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_frustrations_on_user_id"
  end

  create_table "histories", force: :cascade do |t|
    t.text "owner"
    t.bigint "owner_id"
    t.bigint "version"
    t.json "data"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["owner_id"], name: "idx_672027_index_histories_on_owner_id"
    t.index ["user_id"], name: "index_histories_on_user_id"
    t.index ["version"], name: "idx_672027_index_histories_on_version"
  end

  create_table "interview_cheat_sheets", force: :cascade do |t|
    t.timestamptz "date"
    t.text "location"
    t.text "company"
    t.text "positon"
    t.text "interviewers"
    t.text "company_info"
    t.text "my_pitch"
    t.text "accomplishments_skills"
    t.text "reason_about_position"
    t.text "my_questions"
    t.text "predicted_question_answers"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.text "my_first_impression"
    t.text "result"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_interview_cheat_sheets_on_user_id"
  end

  create_table "learnings", force: :cascade do |t|
    t.text "title"
    t.text "concepts"
    t.boolean "finished"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_learnings_on_user_id"
  end

  create_table "memories", force: :cascade do |t|
    t.text "title"
    t.text "content"
    t.text "feeling"
    t.text "lessons"
    t.text "use_cases"
    t.text "channeling_ways"
    t.text "dangers"
    t.text "conclusions"
    t.bigint "repeated"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_memories_on_user_id"
  end

  create_table "my_offers", force: :cascade do |t|
    t.text "title"
    t.text "story"
    t.text "present"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_my_offers_on_user_id"
  end

  create_table "reflections", force: :cascade do |t|
    t.text "title"
    t.bigint "nature"
    t.text "content"
    t.text "action"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.text "place"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_reflections_on_user_id"
  end

  create_table "shift_shames", force: :cascade do |t|
    t.text "emotion_behind_shame"
    t.text "seperate_people_story"
    t.text "shift_to_appriciaton"
    t.text "uncover_emotion_root"
    t.text "realign_with_values"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_shift_shames_on_user_id"
  end

  create_table "stories", force: :cascade do |t|
    t.text "nugget"
    t.text "situation"
    t.text "action"
    t.text "result"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_stories_on_user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "weekly_plan_id"
    t.text "name"
    t.bigint "interval"
    t.timestamptz "start_time"
    t.timestamptz "end_time"
    t.bigint "duration"
    t.bigint "status"
    t.text "feelings"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_tasks_on_user_id"
    t.index ["weekly_plan_id"], name: "idx_672056_index_tasks_on_weekly_plan_id"
  end

  create_table "topics", force: :cascade do |t|
    t.text "title"
    t.text "description"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_topics_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "email", default: ""
    t.text "encrypted_password", default: ""
    t.text "reset_password_token"
    t.timestamptz "reset_password_sent_at"
    t.timestamptz "remember_created_at"
    t.text "username"
    t.text "code"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.text "provider"
    t.text "uid"
    t.text "otp_secret"
    t.bigint "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.index ["email"], name: "idx_672045_index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "idx_672045_index_users_on_reset_password_token", unique: true
  end

  create_table "weekly_plans", force: :cascade do |t|
    t.text "title"
    t.bigint "week"
    t.text "notes"
    t.text "reflect"
    t.text "actions"
    t.text "ideas"
    t.timestamptz "created_at"
    t.timestamptz "updated_at"
    t.bigint "nature"
    t.bigint "user_id", default: 1, null: false
    t.index ["user_id"], name: "index_weekly_plans_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id", name: "active_storage_attachments_blob_id_fkey"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id", name: "active_storage_variant_records_blob_id_fkey"
  add_foreign_key "applications", "users"
  add_foreign_key "auto_suggestions", "users"
  add_foreign_key "comments", "topics", name: "comments_topic_id_fkey"
  add_foreign_key "comments", "users"
  add_foreign_key "email_messages", "users"
  add_foreign_key "englishes", "users"
  add_foreign_key "flashcards", "users"
  add_foreign_key "frustrations", "users"
  add_foreign_key "histories", "users"
  add_foreign_key "interview_cheat_sheets", "users"
  add_foreign_key "learnings", "users"
  add_foreign_key "memories", "users"
  add_foreign_key "my_offers", "users"
  add_foreign_key "reflections", "users"
  add_foreign_key "shift_shames", "users"
  add_foreign_key "stories", "users"
  add_foreign_key "tasks", "users"
  add_foreign_key "tasks", "weekly_plans", name: "tasks_weekly_plan_id_fkey"
  add_foreign_key "topics", "users"
  add_foreign_key "weekly_plans", "users"
end
