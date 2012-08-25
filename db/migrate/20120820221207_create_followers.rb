class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :id
      t.string :screen_name
      t.integer :utc_offset
      t.string :time_zone
      t.string :lang
      t.boolean :following
      t.boolean :follow_request_sent
      t.datetime :notified_at

      t.timestamps
    end
  end
end
