require_relative 'services/read_file'
require_relative 'services/construct_hands'
require_relative 'services/evaluate_hands'

class PokerGame

  def  initialize
    file = ReadFile.new.call
    @players = ConstructHands.new(file).call
    @hand_results = []
  end

  def play_game

    @players["player_one"].each_index do |index|
      hand_one = @players["player_one"][index]
      hand_two = @players["player_two"][index]
      @hand_results << EvaluateHands.new(hand_one, hand_two).call
    end
    puts "Heyooo"
  end
end