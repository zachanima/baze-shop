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

ActiveRecord::Schema.define(:version => 20100309010626) do

  create_table "categories", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  create_table "images", :force => true do |t|
    t.integer  "template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "data_updated_at"
    t.string   "name"
  end

  add_index "images", ["template_id"], :name => "index_images_on_template_id"

  create_table "images_products", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "image_id"
  end

  create_table "option_groups", :force => true do |t|
    t.string   "name"
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "option_groups_products", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "option_group_id"
  end

  create_table "options", :force => true do |t|
    t.string   "text"
    t.integer  "option_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "separator"
  end

  create_table "options_products", :id => false, :force => true do |t|
    t.integer "product_id"
    t.integer "option_id"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", :force => true do |t|
    t.integer  "category_id"
    t.integer  "template_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "link"
    t.text     "text",              :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username_text"
    t.string   "password_text"
    t.boolean  "closed"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "currency"
  end

  create_table "templates", :force => true do |t|
    t.string   "name"
    t.string   "number"
    t.string   "brand"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "department"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "login"
    t.string   "password"
    t.text     "comment"
    t.text     "text"
    t.string   "persistence_token"
    t.datetime "last_request_at"
  end

end
