require 'rubygems'
require 'spec'
require File.join( File.dirname(__FILE__), "..", "smtp_echo.rb" )
describe SmtpEcho do
  before do
    @s_echo = SmtpEcho.new {}
    @message_sender = 'Tim'
    @message = 'Hi Boris'
    
    EventMachine::run do
      host = '0.0.0.0'
      port = 8080
      EventMachine::start_server host, port, SmtpEcho
    end
  end
  
  after do
    EventMachine::stop_event_loop
  end
  
  it "should receive a message" do
    @s_echo.receive_message
  end
  
  it "should echo the message back to the sender" do
		c = nil
		EM.run {
			EM.start_server( Localhost, Localport, Mailserver ) {|conn| c = conn}
			EM::Timer.new(2) {EM.stop} # prevent hanging the test suite in case of error
			EM::Protocols::SmtpClient.send :host=>Localhost,
				:port=>Localport,
				:domain=>"bogus",
				:from=>"larry.page@gmail.com",
				:to=>"sergey.brin@gmail.com",
				:header=> {"Subject"=>"Email subject line", "Reply-to"=>"me@example.com"},
				:body=>"did you see idol?"

		}
		c.my_msg_body.shoud == "did you see idol?"
		c.my_sender.should == "<larry.page@gmail.com>"
		c.my_recipients.should == ["<sergey.brin@gmail.com>"]
	end
  
end