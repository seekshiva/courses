class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :term
      t.references :user
      t.boolean :attending

      t.timestamps
    end
  end
end
