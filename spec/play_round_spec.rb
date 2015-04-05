require_relative '../services/play_round'
require_relative '../services/construct_hands'
require_relative '../services/evaluate_hands'

describe PlayRound do
  describe "#call" do
    let(:cards_array)     { ["5C", "AD", "5D", "KC", "9C", "7C", "5H", "8D", "TD", "KS"]  }
    let(:players)         { ConstructHands.new(cards_array).call }
    let(:hand_one)        { players["player_one"][0] }
    let(:hand_two)        { players["player_two"][0] }
    let(:evaluated_hands) { EvaluateHands.new(hand_one, hand_two).call }

    context 'neither player has a valuable combination' do
      context 'player one has the highest card' do
        let(:cards_array) { ["5C", "AD", "4D", "KC", "9C", "7C", "5H", "8D", "TD", "KS"]  }
        it "awards the round to player two" do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has the highest card' do
        let(:cards_array) { ["5C", "2D", "4D", "KC", "9C", "7C", "5H", "AD", "TD", "KS"]  }
        it "awards the round to player two" do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end
    end

    context 'one player has a single pair and the other has nothing' do
      context 'player one has one pair, player two has nothing' do
        let(:cards_array) { ["5C", "5D", "4D", "KC", "9C", "7C", "5H", "AD", "TD", "KS"]  }
        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end

    context 'both players have a single pair' do
      context 'player one has the higher pair' do
        let(:cards_array) { ["5C", "5D", "4D", "KC", "9C", "7C", "5H", "3D", "3D", "KS"]  }
        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end
  end
end