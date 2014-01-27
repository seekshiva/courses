class CreateXmppUsers < ActiveRecord::Migration
  def connection
    ActiveRecord::Base.establish_connection("xmpp").connection
  end

  def change
    create_table :users do |t|
      t.string :username
      t.text :password
      
      t.timestamps
    end
    ActiveRecord::Base.establish_connection("#{Rails.env}").connection
  end
end
