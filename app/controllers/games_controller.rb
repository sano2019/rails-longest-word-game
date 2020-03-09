class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = ""
   if included?
    check_api
      if @response["found"] == true
        @score = @response["length"].to_i
        @answer = "Congratulations! #{params['word']} is a valid English word! You have #{@score} points"
      elsif
        @response["found"] == false
        @answer = "Sorry but #{params['word']} does not seem to be a valid English word"
      end
    else @answer = "Sorry but #{params['word']} can't be built out of #{params['letters']}"
    end
  end


private

  def check_api
    require 'json'
    require 'open-uri'

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    @response = JSON.parse(open(url).read)
  end

  def included?
    word = params["word"].split("")
    word.all? { |letter| word.count(letter) <= params['letters'].count(letter) }
  end
end

# check that the word can be formed from the current array of letters
# IF FALSE print "Sorry but WORD can't be built out of @letters"
# check that the word is true in the check API
# IF FALSE print "Sorry but WORD does not seem to be a valid English word"


# => <ActionController::Parameters {"authenticity_token"=>"wpgY3sXtrprwwCZGOx2VKxyvkI4FIYGqC0Toq+vEYPjpL++gTKTNOpnG1AkViCc3rKGEGOSpJmrTVtOozhdkWw==",
# "word"=>"KNOL", "controller"=>"games", "action"=>"score"} permitted: false>
