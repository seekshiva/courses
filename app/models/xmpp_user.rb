class XmppTables < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :xmpp 
end

class XmppUser < XmppTables
  self.table_name = "users"
  
  attr_accessible :username, :password

end