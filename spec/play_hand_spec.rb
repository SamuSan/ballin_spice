require_relative '../services/construct_hands.rb'
require_relative '../services/evaluate_hands.rb'

describe EvaluateHands do
  describe "#call" do
    let(:cards_array) { ["5C", "AD", "5D", "KC", "9C", "7C", "5H", "8D", "TD", "KS"]  }
    let(:players)     { ConstructHands.new(cards_array).call }
    let(:hand_one)    { players["player_one"][0] }
    let(:hand_two)    { players["player_two"][0] }

    context "there is a pair in player_one_hand" do
      let(:expected_hand_evaluation) { { 'one_pair' => [5], 'rank' => 1 } }

      it "returns an evaluation of one pair of 5s" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there are two pair in player_one_hand" do
      let(:cards_array) { ["5C", "AD", "5D", "AC", "9C", "7C", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'two_pair' => [5, 14], 'rank' => 2 } }

      it "returns an evaluation of two pair, 5s and Aces" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there are three of a kind in player_one_hand" do
      let(:cards_array) { ["5C", "AD", "5D", "KC", "5S", "7C", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'three_of_a_kind' => [5], 'rank' => 3 } }

      it "returns an evaluation of three of a kind of 5s" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there is a straight in player_one_hand" do
      let(:cards_array) { ["5C", "6D", "7D", "8C", "9S", "7C", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'straight' => [5], 'rank' => 4 } }

      it "returns aan evaluation of straight 5 to 9" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there is a flush in player_one_hand" do
      let(:cards_array) { ["5C", "AC", "2C", "KC", "3C", "7C", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'flush' => [:c], 'rank' => 5 } }

      it "returns an evaluation of flush in clubs" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there is a full house in player_one_hand" do
      let(:cards_array) { ["5C", "5D", "5S", "KC", "KH", "7C", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'full_house' => [5,13], 'rank' => 6 } }

      it "returns a score of 6" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there are four of a kind in player_one_hand" do
      let(:cards_array) { ["5C", "5D", "5S", "5H", "KH", "7C", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'four_of_a_kind' => [5], 'rank' => 7 } }

      it "returns an evaluation of four_of_a_kind in player_one_hand" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there is a straight flush in player_one_hand" do
      let(:cards_array) { ["5C", "6C", "7C", "8C", "9C", "7D", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'straight_flush' => [:c, 5], 'rank' => 8 } }

      it "returns an evaluation of straight_flush in player_one_hand" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    context "there is a royal flush in player_one_hand" do
      let(:cards_array) { ["TC", "JC", "QC", "KC", "AC", "7D", "5H", "8D", "TD", "KS"]  }
      let(:expected_hand_evaluation) { { 'royal_flush' => [:c], 'rank' => 9 } }

      it "returns an evaluation of roayl flush in player_one_hand" do
        check_evaluations(expected_hand_evaluation)
      end
    end

    def check_evaluations(expected_hand_evaluation)
      actual_evaluation = EvaluateHands.new(hand_one, hand_two).call['player_one']
      expect(actual_evaluation).to eq expected_hand_evaluation
    end
  end
end