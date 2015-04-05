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

    context 'one pair' do
      context 'player one has one pair, player two has nothing' do
        let(:cards_array) { ["5C", "5D", "4D", "KC", "9C", "7C", "5H", "AD", "TD", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'both players have a single pair' do
        context 'player one has the higher pair' do
          let(:cards_array) { ["5C", "5D", "4D", "KC", "9C", "7C", "5H", "3D", "3S", "KS"]  }

          it "awards the round to player one " do
            expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
          end
        end

        context 'player two has the higher pair' do
          let(:cards_array) { ["5C", "5D", "4D", "KC", "9C", "7C", "5H", "6D", "6S", "KS"]  }

          it "awards the round to player one " do
            expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
          end
        end
      end
    end

    context 'two pair' do
      context 'player one has two pair, player two has nothing' do
        let(:cards_array) { ["5C", "5D", "4D", "4C", "9C", "7C", "5H", "AD", "TD", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'both players have a two pair' do
        context 'player one has the higher pair' do
          let(:cards_array) { ["5C", "5D", "4D", "4C", "9C", "2C", "2H", "3D", "TD", "3S"]  }

          it "awards the round to player one " do
            expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
          end
        end

        context 'player two has the higher pair' do
          let(:cards_array) { ["5C", "5D", "4D", "4C", "9C", "7C", "7H", "3D", "3S", "KS"]  }

          it "awards the round to player one " do
            expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
          end
        end
      end
    end

    context 'three of a kind' do
      context 'player one has three of a kind and player two has nothing' do
        let(:cards_array) { ["5C", "5D", "4D", "5S", "9C", "7C", "5H", "3S", "9D", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has three of a kind' do
        let(:cards_array) { ["5C", "5D", "4D", "KC", "9C", "7C", "7H", "6D", "7D", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end

      context 'both players have three of a kind, player one has the higher of the two' do
        let(:cards_array) { ["8C", "8D", "4D", "8S", "9C", "7C", "7H", "6D", "7D", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end

    context 'straight' do
      context 'player one has straight and player two has nothing' do
        let(:cards_array) { ["5C", "6D", "7S", "8S", "9C", "7C", "5H", "3S", "9D", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has straight and player one has nothing' do
        let(:cards_array) { ["7C", "5H", "3S", "9D", "KS", "5C", "6D", "7S", "8S", "9C"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end

      context 'both players have a straight, player one has the higher of the two' do
        let(:cards_array) { ["5C", "6D", "7S", "8S", "9C", "4C", "5H", "6S", "7D", "8D"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end

    context 'flush' do
      context 'player one has a flush and player two has nothing' do
        let(:cards_array) { ["4D", "6D", "7D", "8D", "9D", "7C", "5H", "3S", "TD", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has a flush and player one has nothing' do
        let(:cards_array) { ["7S", "5H", "3S", "9D", "KS", "5C", "6C", "7C", "2C", "TC"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end

      context 'both players have a flush, player one has the higher of the two' do
        let(:cards_array) { ["4D", "6D", "7D", "8D", "AD", "5C", "6C", "7C", "2C", "TC"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'both players have a flush, they are equal' do
        let(:cards_array) { ["4D", "6D", "7D", "8D", "AD", "4C", "6C", "7C", "8C", "AC"]  }

        it "shoudl split the pot" do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 0
        end
      end
    end

    context 'full house' do
      context 'player one has a full house and player two has nothing' do
        let(:cards_array) { ["4D", "4S", "4H", "8D", "8S", "7C", "5H", "3S", "TD", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has a full house and player one has nothing' do
        let(:cards_array) { ["7C", "5H", "3S", "TD", "KS", "4D", "4S", "4H", "8D", "8S"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end

      context 'both players have a full house, player one has the higher of the two' do
        let(:cards_array) { ["7C", "7H", "7S", "TD", "TS", "4D", "4S", "4H", "8D", "8S"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end

    context 'four of a kind' do
      context 'player one has a four of a kind and player two has nothing' do
        let(:cards_array) { ["4D", "4S", "4H", "4C", "8S", "7C", "5H", "3S", "TD", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has a four of a kind and player one has nothing' do
        let(:cards_array) { ["7C", "5H", "3S", "TD", "KS", "4D", "4S", "4H", "4C", "8S"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end

      context 'both players have a four of a kind, player one has the higher of the two' do
        let(:cards_array) { ["5C", "5H", "5S", "5D", "KS", "4D", "4S", "4H", "4C", "8S"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end

    context 'straight flush' do
      context 'player one has a straight flush and player two has nothing' do
        let(:cards_array) { ["4D", "5D", "6D", "7D", "8D", "7C", "5H", "3S", "TD", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has a straight flush and player one has nothing' do
        let(:cards_array) { ["7C", "5H", "3S", "TD", "KS", "4D", "5D", "6D", "7D", "8D"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end

      context 'both players have a straight flush, player one has the higher of the two' do
        let(:cards_array) { ["4D", "5D", "6D", "7D", "8D", "3C", "4C", "5C", "6C", "7C"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end

    context 'royal flush' do
      context 'player one has a royal flush and player two has nothing' do
        let(:cards_array) { ["TD", "JD", "QD", "KD", "AD", "7C", "5H", "3S", "TD", "KS"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end

      context 'player two has a royal flush and player one has nothing' do
        let(:cards_array) { ["7C", "5H", "3S", "TD", "KS", "TD", "JD", "QD", "KD", "AD"]  }

        it "awards the round to player one " do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 2
        end
      end

      context 'both players have a royal flush' do
        let(:cards_array) { ["TC", "JC", "QC", "KC", "AC", "TD", "JD", "QD", "KD", "AD"]  }

        it "should split the pot" do
          expect(PlayRound.new(hand_one, hand_two, evaluated_hands).call).to eq 1
        end
      end
    end
  end
end