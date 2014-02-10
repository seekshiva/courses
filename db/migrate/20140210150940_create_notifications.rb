class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :message_id
      t.string :user_id

      t.timestamps
    end
  end
end
