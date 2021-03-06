class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word, guesses="",wrong_guesses="")
    @word = word
    @guesses =guesses
    @wrong_guesses=wrong_guesses
  end


  def guess(char)
    throw ArgumentError if char.nil?
    throw ArgumentError if char.empty? or !!(char =~ /[^a-zA-Z]/)
    char = char.downcase
    #controles
    #acierta
    return false if check_used_letter(char)
    
    if @word.include?(char)
      @guesses += char
    else 
      @wrong_guesses += char
    end
    
  end
  
  def check_used_letter(char)
    return true if char.nil? or @guesses.include?(char) or @wrong_guesses.include?(char)
  end
  
  def word_with_guesses
    out = ""
    @word.each_char do |char|
      if @guesses.include?(char)
        out += char
      else
        out += '-'
      end
    end
    out
  end


  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word == self.word_with_guesses
    :play
  end


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
