require_relative 'services/read_file'
require_relative 'services/construct_hands'
require_relative 'services/evaluate_hands'

class PokerGame

  def  initialize
    file = ReadFile.new.call
    @players = ConstructHands.new(file).call
    @results = []
  end

  def play_game
    @current_round = 0
    evaluated_hands = []

    @players["player_one"].each_index do |index|
      hand_one = @players["player_one"][index]
      hand_two = @players["player_two"][index]
      evaluated_hands = EvaluateHands.new(hand_one, hand_two).call
      @results << PlayRound.new(hand_one, hand_two, evaluated_hands).call
    end
    puts "Of 1000 games Player One won #{@results.select { |elem| elem == 1 }.length}"
    puts "Player Two won #{@results.select { |elem| elem == 2 }.length}"
  end
end