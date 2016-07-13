class CreateOauths < ActiveRecord::Migration
  def change
    create_table :oauths do |t|
      t.integer  "user_id"
      t.string   "openid"
      t.string   "nickname"
      t.integer  "sex"
      t.string   "city"
      t.string   "province"
      t.string   "country"
      t.string   "headimgurl"
      t.text     "privilege"
      t.boolean  "subscribe"
      t.date     "subscribed_at"
      t.string   "unionid"

      t.timestamps null: false
    end
  end
end
