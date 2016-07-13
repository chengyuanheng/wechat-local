class CreatQrcodes < ActiveRecord::Migration
  def change
    create_table :qrcodes do |t|
      t.string   "name"
      t.string   "url"
      t.integer  "action_name"

      t.timestamps null: false
    end
  end
end
