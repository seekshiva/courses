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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130324122900) do

  create_table "authors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "book_authors", :force => true do |t|
    t.integer  "book_id"
    t.integer  "author_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "book_authors", ["author_id"], :name => "index_book_authors_on_author_id"
  add_index "book_authors", ["book_id"], :name => "index_book_authors_on_book_id"

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "publisher"
    t.string   "edition"
    t.string   "isbn"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "class_topics", :force => true do |t|
    t.integer  "classroom_id"
    t.integer  "topic_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "class_topics", ["classroom_id"], :name => "index_class_topics_on_class_id"
  add_index "class_topics", ["topic_id"], :name => "index_class_topics_on_topic_id"

  create_table "classrooms", :force => true do |t|
    t.integer  "term_id"
    t.date     "date"
    t.string   "time"
    t.string   "room"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "classrooms", ["term_id"], :name => "index_classrooms_on_term_id"

  create_table "course_references", :force => true do |t|
    t.integer  "course_id"
    t.integer  "book_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "course_references", ["book_id"], :name => "index_course_references_on_book_id"
  add_index "course_references", ["course_id"], :name => "index_course_references_on_course_id"

  create_table "courses", :force => true do |t|
    t.string   "subject_code"
    t.string   "name"
    t.integer  "credits"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "name"
    t.string   "hod"
    t.string   "short"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "rollno_prefix"
  end

  create_table "faculties", :force => true do |t|
    t.integer  "user_id"
    t.string   "prefix"
    t.string   "designation"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "faculties", ["user_id"], :name => "index_faculties_on_user_id"

  create_table "references", :force => true do |t|
    t.integer  "course_reference_id"
    t.integer  "topic_id"
    t.string   "sections"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "references", ["course_reference_id"], :name => "index_references_on_course_reference_id"
  add_index "references", ["topic_id"], :name => "index_references_on_topic_id"

  create_table "term_departments", :force => true do |t|
    t.integer  "term_id"
    t.integer  "department_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "term_departments", ["department_id"], :name => "index_term_departments_on_department_id"
  add_index "term_departments", ["term_id"], :name => "index_term_departments_on_term_id"

  create_table "term_faculties", :force => true do |t|
    t.integer  "term_id"
    t.integer  "faculty_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "term_faculties", ["faculty_id"], :name => "index_term_faculties_on_faculty_id"
  add_index "term_faculties", ["term_id"], :name => "index_term_faculties_on_term_id"

  create_table "terms", :force => true do |t|
    t.integer  "course_id"
    t.integer  "academic_year"
    t.integer  "semester"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "venue"
  end

  add_index "terms", ["course_id"], :name => "index_terms_on_course_id"

  create_table "topics", :force => true do |t|
    t.integer  "course_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "ct_status",   :default => ""
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "department_id"
    t.boolean  "activated"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "admin",         :default => false
  end

  add_index "users", ["department_id"], :name => "index_users_on_department_id"

end
