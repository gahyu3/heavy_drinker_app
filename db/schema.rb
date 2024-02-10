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

ActiveRecord::Schema[7.0].define(version: 20_240_206_193_832) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'authentications', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'provider', null: false
    t.string 'uid', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[provider uid], name: 'index_authentications_on_provider_and_uid'
  end

  create_table 'categories', force: :cascade do |t|
    t.string 'name', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'drinks', force: :cascade do |t|
    t.string 'name', null: false
    t.integer 'degree', null: false
    t.integer 'volume', null: false
    t.bigint 'category_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['category_id'], name: 'index_drinks_on_category_id'
    t.index ['user_id'], name: 'index_drinks_on_user_id'
  end

  create_table 'follows', force: :cascade do |t|
    t.integer 'follower_id', null: false
    t.integer 'followed_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'notification_settings', force: :cascade do |t|
    t.boolean 'day', default: true
    t.boolean 'week', default: true
    t.boolean 'month', default: true
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_notification_settings_on_user_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.integer 'rank', null: false
    t.integer 'period', null: false
    t.boolean 'check', default: false
    t.date 'start_date', null: false
    t.date 'end_date', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'records', force: :cascade do |t|
    t.date 'date', null: false
    t.integer 'quantity', null: false
    t.bigint 'drink_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['drink_id'], name: 'index_records_on_drink_id'
    t.index ['user_id'], name: 'index_records_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'crypted_password'
    t.string 'salt'
    t.string 'avatar'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_token_expires_at'
    t.datetime 'reset_password_email_sent_at'
    t.integer 'access_count_to_reset_password_page', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token'
  end

  add_foreign_key 'drinks', 'categories'
  add_foreign_key 'drinks', 'users'
  add_foreign_key 'notification_settings', 'users'
  add_foreign_key 'notifications', 'users'
  add_foreign_key 'records', 'drinks'
  add_foreign_key 'records', 'users'
end
