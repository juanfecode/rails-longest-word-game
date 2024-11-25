require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word]
    letters = params[:letters]
    if validattempt?(letters, @word)
      url = "https://dictionary.lewagon.com/#{@word}"
      request = URI.open(url).read
      response = JSON.parse(request)
      response["found"] ? endgame(response) : @score = { score: 0, message: "loser" }
    else
      @score = { score: 0, message: "invalid word" }
    end
  end

  def validattempt?(letters, word)
    response = word.chars.all? do |ltr|
      word.count(ltr.upcase) >= letters.count(ltr)
    end
    return response
  end

  def endgame(word)
    score = (word["length"]) * 100 / 10
    @score = { score: score, message: "you have points" }
  end
end
