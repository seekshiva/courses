class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.reference :term_id
      t.references :user_id
      t.boolean :attending

      t.timestamps
    end
  end
end
