module Message
  class Response

    attr_accessor :message

    def self.from(message)
      Command.process(message)
    end

    def self.name_change(message)
      message.response = "notes the name change."
      message
    end

    def self.greeting(message)
      message.response = Alice::Util::Randomizer.greeting(message.sender_nick)
      message
    end

    def self.heartbeat(message)
      message.response = Handlers::Heartbeat.process(message, :random_act)
      message
    end

    def self.preview_url(message)
      message.response = Parser::URL.new(message.trigger).preview
      message
    end

    def self.well_actually(message)
      message.sender.penalize
      message.response = "Well actually, you just lost points. :("
      message
    end

    def self.so_say_we_all(message)
      message.response = "So say we all!"
      message
    end

  end
end