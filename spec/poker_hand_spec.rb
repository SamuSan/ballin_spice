require_relative '../poker_hand.rb'

describe PokerHand do
  let(:card_string) { "8C TS KC 9H 4S" }


  describe "initialize" do
    it "take a string of card desc and constructs cards" do
      poker_hand = PokerHand.new(card_string)
      expect(poker_hand.cards.length).to eq 5
    end

    it "assigns the correct value to face cards" do
      poker_hand = PokerHand.new(card_string)
      expect(poker_hand.cards[1].value).to eq 10
    end
  end
end