require 'nokogiri'

module Parser
  class Google

    attr_accessor :question

    def self.fetch(topic)
      new(topic).answer
    end

    def self.fetch_all(topic)
      new(topic).all_answers
    end

    def initialize(question)
      @question = question.gsub("+", "plus").gsub(" ", "+").encode("ASCII", invalid: :replace, undef: :replace, replace: '')
    end

    def answer
      results.first
    end

    def all_answers
      answers
    end

    private

    def answers
      answers = (full_search + reductivist_search).compact.map{ |a| a.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '') }
#      answers = (reductivist_search).compact.map{ |a| a.encode('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '') }
      answers.reject!{ |a| a =~ /\.\.\./}
    rescue Exception => e
      Alice::Util::Logger.info "*** Parser::Google: Unable to process \"#{self.question}\": #{e}"
      Alice::Util::Logger.info e.backtrace
      return ["Hmm, that part of my brain is returning a #{e}. Google is getting suspicious. You should probably rotate my IP address again."]
    end

    def results
      best_answer = answers.any? ? Grammar::DeclarativeSorter.sort(query: question, corpus: answers).first : ""
      Alice::Util::Logger.info "*** Parser::Google: Answered \"#{self.question}\" with #{best_answer}"
      return best_answer
    rescue Exception => e
      Alice::Util::Logger.info "*** Parser::Google: Unable to process \"#{self.question}\": #{e}"
      Alice::Util::Logger.info e.backtrace
      return ["Hmm, that part of my brain is returning a #{e}"]
    end

    def full_search
      doc = Nokogiri::HTML(open("https://www.google.com/search?q=#{question}"))
      doc.css("div span.st").map(&:text)
    end

    def reductivist_search
      doc = Nokogiri::HTML(open("https://www.google.com/search?q=#{simplified_question}"))
      doc.css("div span.st").map(&:text)
    end

    def simplified_question
      parsed_question = Grammar::SentenceParser.parse(question)
      "wikipedia what is #{(parsed_question.nouns + parsed_question.adjectives).join(' ')}"
    end

  end
end
