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

ActiveRecord::Schema.define(:version => 20090821163024) do

  create_table "shops", :force => true do |t|
    t.string "name",         :limit => 40, :null => false
    t.string "manager_name", :limit => 40, :null => false
  end

  create_table "users", :force => true do |t|
    t.integer  "fbid",       :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name", :limit => 80
    t.string   "last_name",  :limit => 80
    t.string   "picture",    :limit => 200
  end

  add_index "users", ["fbid"], :name => "index_users_on_fbid", :unique => true

  create_table "wishes", :force => true do |t|
    t.integer  "user_id",                                     :null => false
    t.integer  "shop_id",                                     :null => false
    t.string   "sku",         :limit => 40,                   :null => false
    t.string   "description", :limit => 100, :default => "",  :null => false
    t.float    "unit_price",                 :default => 0.0, :null => false
    t.float    "quantity",                   :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wishes", ["shop_id", "user_id"], :name => "index_wishes_on_shop_id_and_user_id"

end
