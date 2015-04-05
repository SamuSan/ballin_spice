require_relative "../poker_hand.rb"

class ConstructHands

  def initialize(file)
    @file = file
    @player_one = []
    @player_two = []
  end

  def call
    @file.each_slice(10) do |deal|
      @player_one << PokerHand.new(deal[0,5])
      @player_two << PokerHand.new(deal[5,9])
    end
    { "player_one" => @player_one,
      "player_two" => @player_two }
  end
end