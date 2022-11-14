class GamesController < ApplicationController
  def new
    @tirage = Array.new(8) { ('A'..'Z').to_a.sample }
  end

  def score
    @tirage = params[:tirage].split
    @word = params[:guess].upcase
    worda = @word.split('')
    user = JSON.parse(URI.open("https://wagon-dictionary.herokuapp.com/#{@word}").read)

    @message = "#{@word} not seems to be an english word"
    return unless user['found']

    @message = "Nice job with #{@word}.It's a valid english word"
    @score = user['length']
    worda.each do |letter|
      index = @tirage.find_index(letter)
      next @tirage.delete_at(index) if index

      return @message = 'Le mot doit être composé avec les lettres données'
    end
  end
end
