class Notification < ActiveRecord::Base

  belongs_to :user
  attr_accessible :message_id, :user_id

  def send_notification(user, body)
    msg = Blather::Stanza::Message.new
    msg.to = user.email+'@courseshub'
    msg.body = body
    msg.id = SecureRandom.hex(8)

    self.message_id = msg.id
    self.user_id = user.id
    self.save()
    
    Courses::Application.config.client.write_to_stream msg
  end

  def notify_term(term_id)
  end
end
