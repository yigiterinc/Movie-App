# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_04_07_221831) do

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "movie_genres", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_movie_genres_on_genre_id"
    t.index ["movie_id"], name: "index_movie_genres_on_movie_id"
  end

  create_table "movie_stars", force: :cascade do |t|
    t.integer "movie_id", null: false
    t.integer "star_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_movie_stars_on_movie_id"
    t.index ["star_id"], name: "index_movie_stars_on_star_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "year"
    t.date "released"
    t.string "runtime"
    t.string "director"
    t.text "plot"
    t.string "language"
    t.float "metascore"
    t.float "imdb_rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stars", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_genres", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "genre_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["genre_id"], name: "index_user_genres_on_genre_id"
    t.index ["user_id"], name: "index_user_genres_on_user_id"
  end

  create_table "user_movies", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "movie_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_user_movies_on_movie_id"
    t.index ["user_id"], name: "index_user_movies_on_user_id"
  end

  create_table "user_stars", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "star_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["star_id"], name: "index_user_stars_on_star_id"
    t.index ["user_id"], name: "index_user_stars_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
  add_foreign_key "movie_stars", "movies"
  add_foreign_key "movie_stars", "stars"
  add_foreign_key "user_genres", "genres"
  add_foreign_key "user_genres", "users"
  add_foreign_key "user_movies", "movies"
  add_foreign_key "user_movies", "users"
  add_foreign_key "user_stars", "stars"
  add_foreign_key "user_stars", "users"
end
