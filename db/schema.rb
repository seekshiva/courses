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

ActiveRecord::Schema.define(version: 20140114204358) do

  create_table "authors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "about"
  end

  create_table "avatars", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "book_authors", force: true do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "book_authors", ["author_id"], name: "index_book_authors_on_author_id", using: :btree
  add_index "book_authors", ["book_id"], name: "index_book_authors_on_book_id", using: :btree

  create_table "book_covers", force: true do |t|
    t.integer  "uploaded_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "publisher"
    t.string   "edition"
    t.string   "isbn"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "online_retail_url"
    t.integer  "book_cover_id"
    t.integer  "file_id"
  end

  create_table "class_topics", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "class_topics", ["classroom_id"], name: "index_class_topics_on_classroom_id", using: :btree
  add_index "class_topics", ["topic_id"], name: "index_class_topics_on_topic_id", using: :btree

  create_table "classrooms", force: true do |t|
    t.integer  "term_id"
    t.date     "date"
    t.string   "time"
    t.string   "room"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classrooms", ["term_id"], name: "index_classrooms_on_term_id", using: :btree

  create_table "courses", force: true do |t|
    t.string   "subject_code"
    t.string   "name"
    t.integer  "credits"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about"
  end

  create_table "departments", force: true do |t|
    t.string   "name"
    t.string   "short"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "rollno_prefix"
    t.integer  "hod_id"
  end

  create_table "documents", force: true do |t|
    t.integer  "uploaded_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
  end

  create_table "faculties", force: true do |t|
    t.integer  "user_id"
    t.string   "prefix"
    t.string   "designation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about"
  end

  add_index "faculties", ["user_id"], name: "index_faculties_on_user_id", using: :btree

  create_table "references", force: true do |t|
    t.integer  "term_reference_id"
    t.integer  "topic_id"
    t.string   "indices"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "references", ["term_reference_id"], name: "index_references_on_term_reference_id", using: :btree
  add_index "references", ["topic_id"], name: "index_references_on_topic_id", using: :btree

  create_table "section_documents", force: true do |t|
    t.integer  "document_id"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: true do |t|
    t.integer  "term_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "term_id"
    t.integer  "user_id"
    t.boolean  "attending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_departments", force: true do |t|
    t.integer  "term_id"
    t.integer  "department_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_departments", ["department_id"], name: "index_term_departments_on_department_id", using: :btree
  add_index "term_departments", ["term_id"], name: "index_term_departments_on_term_id", using: :btree

  create_table "term_documents", force: true do |t|
    t.integer  "document_id"
    t.integer  "term_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "term_faculties", force: true do |t|
    t.integer  "term_id"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_faculties", ["faculty_id"], name: "index_term_faculties_on_faculty_id", using: :btree
  add_index "term_faculties", ["term_id"], name: "index_term_faculties_on_term_id", using: :btree

  create_table "term_references", force: true do |t|
    t.integer  "term_id"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_references", ["book_id"], name: "index_term_references_on_book_id", using: :btree
  add_index "term_references", ["term_id"], name: "index_term_references_on_term_id", using: :btree

  create_table "terms", force: true do |t|
    t.integer  "course_id"
    t.integer  "academic_year"
    t.integer  "semester"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "venue"
  end

  add_index "terms", ["course_id"], name: "index_terms_on_course_id", using: :btree

  create_table "topic_documents", force: true do |t|
    t.integer  "document_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "topics", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ct_status",   default: ""
    t.integer  "section_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "",    null: false
    t.integer  "department_id"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                  default: false
    t.string   "phone"
    t.integer  "avatar_id"
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
