require 'rubygems'
require 'eventmachine'

class SmtpEcho < EventMachine::Protocols::SmtpServer
  
  attr_reader :message_content, :sender, :recipient
  	
  def initialize *args
		super
	end
  
  def receive_message
    send_data
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

EventMachine::run do
  host = '0.0.0.0'
  port = 8080
  EventMachine::start_server host, port, SmtpEcho
end