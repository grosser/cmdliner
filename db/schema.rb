# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091003151919) do

  create_table "commands", :force => true do |t|
    t.string   "name",                           :null => false
    t.text     "description",                    :null => false
    t.boolean  "mac_only",    :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "parameter_1"
    t.string   "parameter_2"
  end

  add_index "commands", ["name"], :name => "index_commands_on_name", :unique => true

  create_table "options", :force => true do |t|
    t.string   "name"
    t.string   "alias"
    t.integer  "command_id",  :null => false
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "argument"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                          :null => false
    t.string   "identifier",                    :null => false
    t.string   "email"
    t.string   "website"
    t.boolean  "admin",      :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["name"], :name => "index_users_on_name", :unique => true

end
