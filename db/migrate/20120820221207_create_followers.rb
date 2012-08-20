class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :id
      t.string :screen_name
      t.boolean :follow
      t.datetime :notified_at

      t.timestamps
    end
  end
end
