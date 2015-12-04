require 'rubygems'
require 'twilio-ruby'
class TextNotification
  account_sid = 'ACe11f1fbebc4036e2a3aca5e831930be5'
  auth_token = 'ad9b7653cb2506324f9b2dcfb9fc47a8'
  @client = Twilio::REST::Client.new account_sid, auth_token
  def self.send_text(phone_number, content)
    @client.account.messages.create({
      :from => '+14124263074',
      :to => phone_number,
      :body => content,
      # :media_url => 'http://farm2.static.flickr.com/1075/1404618563_3ed9a44a3a.jpg',
    })
  end
end
