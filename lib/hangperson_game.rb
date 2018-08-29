class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

  def guess(char)
    if char.nil? || char.empty? || ! (char =~ /[[:alpha:]]/)
      raise ArgumentError
    end

    char.downcase!
    if word[char]
      if ! guesses[char]
        guesses << char
        true
      else
        false
      end
    else
      if ! wrong_guesses[char]
        wrong_guesses << char
        true
      else
        false
      end
    end
  end
end
