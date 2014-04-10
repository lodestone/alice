module Alice

  module Util
    
    class Sanitizer

      def self.process(text)
        text.gsub!("the the ", "the ")
        text.gsub!("the ye ", "ye ")
        text.gsub!("a the ", "a ")
        text.gsub!("a ye ", "ye ")
        text.gsub!("ye ye ", "ye ")
        text.gsub!("a a", "an a")
        text.gsub!("a e", "an e")
        text.gsub!("a i", "an i")
        text.gsub!("a o", "an o")
        text.gsub!(/^am/i, 'is')
        text.gsub!('..', '.')
        text.gsub!('. .', '.')
        text.gsub!('  ', ' ')
        text[0].upcase
        text
      end

      def self.strip_pronouns(text)
        text.gsub!(/^I /i, '')
      end

      def self.ordinal(number)
        number == 1 && "1st" || number == 2 && "2nd" || number == 3 && "3rd" || "#{number}th"
      end

    end

  end

end