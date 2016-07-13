class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   "nickname"
      t.string   "avatar_url"
      t.integer  "register_from_type"
      t.datetime "last_login"
      t.string   "last_ip"
      t.string   "mobile"
      t.string   "mobile_verify_token"
      t.boolean  "mobile_verified", default: false
      t.string   "email"
      t.string   "email_verify_token"
      t.boolean  "email_verified",  default: false

      t.timestamps null: false
    end
  end
end
