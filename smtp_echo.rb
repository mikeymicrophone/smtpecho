require 'rubygems'
require 'eventmachine'

class SmtpEcho < EventMachine::Protocols::SmtpServer
  
  attr_reader :message_content, :sender, :recipient
  	
  def initialize *args
		super
	end
  
  def receive_message(headers, data)
    # I could not figure out how to send a message
    # this class does not respond to :send_message
  end
  
  def receive_sender sender
    @sender = sender
  end
  
  def receive_recipient recipient
    @recipient = recipient
  end
  
  def receive_data_chunk c
		@message_content = c.last
	end
	
	def connection_ended
		EM.stop
	end
	
end

EM::run { EventMachine::start_server '0.0.0.0', 8080, SmtpEcho }