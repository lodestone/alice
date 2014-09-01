module Alice

  module Parser

    module LanguageHelper

      ARTICLES = [
        'a', 'the', 'of', 'an', 'to', 'and'
      ]

      INFO_VERBS = [
        "delete",
        "describe",
        "do",
        "does",
        "examine",
        "had",
        "has",
        "hid",
        "inspect",
        "is",
        "look",
        "made",
        "set",
        "was"
      ]

      INTERROGATIVES = [
        "how",
        "what",
        "when",
        "where",
        "who"
      ]

      NUMBERS = {
        'one' => '1',
        'two' => '2',
        'three' => '3',
        'four' => '4',
        'five' => '5',
        'six' => '6',
        'seven' => '7',
        'eight' => '8',
        'nine' => '9',
        'ten' => '10'
      }

      PREPOSITIONS = [
        "about",
        "at",
        "by",
        "for",
        "from",
        "in",
        "into",
        "of",
        "on",
        "onto",
        "to",
        "toward",
        "towards",
        "with",
        "within",
        "without"
      ]

      TRANSFER_VERBS = [
        "donate",
        "drop",
        "gave",
        "get",
        "give",
        "hand",
        "pass",
        "pick",
        "take"
      ]

      IDENTIFIERS = NUMBERS.keys + NUMBERS.values + ARTICLES

      def self.similar_to(original_word, test_word)
        return true if original_word =~ /#{test_word}/i
        return true if test_word =~ /#{original_word}/i
        RubyFish::Hamming.distance(original_word, test_word) <= 5
      end

    end

  end

end
