# 
# This file is used to Initialize the XMPP connection for the app.
# Restart the Rails if contents of this file have been changed.
# 

require 'blather/client/dsl'

username = Rails.application.config.database_configuration["xmpp_client"]["username"]
password = Rails.application.config.database_configuration["xmpp_client"]["password"]
resource = Rails.application.config.database_configuration["xmpp_client"]["resource"]
domain   = Rails.application.config.database_configuration["xmpp_client"]["domain"]
host     = Rails.application.config.database_configuration["xmpp_client"]["host"]
puts '======================================'
puts 'Initializing Xmpp connection'
puts "Username :  "+username
puts "Password :  "+password
puts "Resource :  "+resource
puts "Domain   :  "+domain
puts "Host     :  "+host
puts "======================================"

class XmppClient
  include Blather::DSL

  def initialize(username, domain, resource, password, host)
    self.setup username+"@"+domain+"/"+resource, password, host
  end
end
  
client = XmppClient.new(username, domain, resource, password, host)
client.when_ready { 
  puts "Xmpp connection established" 
}

client.subscription :request? do |s|
  write_to_stream s.approve!
end
  
client.message :chat?, :body do |m|
  say m.from, "You sent: #{m.body}"
end

Courses::Application.config.client = client
  
Thread.abort_on_exception = true
Thread.new  do 
  EM.run { client.run }
end
