class Notification < ActiveRecord::Base

  belongs_to :user
  attr_accessible :message_id, :user_id

  def send_notification(user, text, link=nil)
    msg = Blather::Stanza::Message.new
    msg.to = user.email+'@courseshub'
    msg.id = SecureRandom.hex(8)
    body = Hash.new()
    body[:msg] = text
    body[:link] = link
    body[:message_id] = msg.id
    msg.body = body.to_json

    self.message_id = msg.id
    self.user_id = user.id
    self.save()
    
    Courses::Application.config.client.write_to_stream msg
  end

  def notify_term(term_id)
  end
end
