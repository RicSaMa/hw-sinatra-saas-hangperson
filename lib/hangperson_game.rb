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
    throw ArgumentError if char==''
    char = char.downcase
    #controles
    throw ArgumentError if char=~ /[^a-z]/
    #acierta
    return false if @guesses.include?(char) or @wrong_guesses.include?(char) 
    
    if @word.include?(char)
      @guesses += char
    else 
      @wrong_guesses += char
    end
    
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
    return :lose if @wrong_guesses.size == 7
    return :win if @guesses.size == @word.size
    :play
  end


  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
