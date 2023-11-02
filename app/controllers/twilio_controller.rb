require 'twilio-ruby'

class TwilioController < ApplicationController

  skip_before_action :verify_authenticity_token

#   def voice
#     response = Twilio::TwiML::VoiceResponse.new do |r|
#       r.say 'Hey there. Congrats on integrating Twilio into your Rails 4 app.', :voice => 'alice'
#          r.Play 'http://linode.rabasa.com/cantina.mp3'
#     end

#     render_twiml response
#   end
    def voice
        client = Twilio::REST::Client.new

        message = client.messages.create(
        to: "+13037208062", # Replace with the recipient's phone number
        from: Rails.application.credentials.phone_number, # Replace with your Twilio phone number
        body: "You are now in the queue for BlackBeard Barber Shop. You are 5th in line"
        )
        head :ok
        puts message.body
    end
end
