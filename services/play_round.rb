class PlayRound
  def initialize(hand_one, hand_two, evaluated_hands)
    @hand_one = hand_one
    @hand_two = hand_two
    @evaluated_hands = evaluated_hands
    @winner = nil
  end

  def call
    play_round
  end

private

  def play_round
    if no_one_has_anything?
      player_one_values = @hand_one.cards.map(&:value).sort.reverse
      player_two_values = @hand_two.cards.map(&:value).sort.reverse
      @winner = highest_card_wins(player_one_values, player_two_values)
    elsif clear_winner?
      if @evaluated_hands['player_one'].nil? && @evaluated_hands['player_two']
        @winner = 2
      elsif @evaluated_hands['player_two'].nil? && @evaluated_hands['player_one']
        @winner = 1
      end
    else
      @winner = decide_winner
    end

    @winner
  end

  def no_one_has_anything?
    @evaluated_hands['player_one'].nil? &&
      @evaluated_hands['player_two'].nil?
  end

  def clear_winner?
    @evaluated_hands['player_one'].nil? ||
      @evaluated_hands['player_two'].nil?
  end

  def highest_card_wins(player_one_values, player_two_values)
    player_one_values.each_index do |index|
      if player_one_values[index] > player_two_values[index]
        return 1
      elsif player_one_values[index] < player_two_values[index]
        return 2
      elsif player_one_values[index] == player_two_values[index]
        return 0
      end
    end
  end

  def decide_winner
    player_one_hand = @evaluated_hands['player_one']
    player_two_hand = @evaluated_hands['player_two']

    if player_one_hand['rank'] > player_two_hand['rank']
      @winner = 1
    elsif player_one_hand['rank'] < player_two_hand['rank']
      @winner = 2
    else
      @winner = compare_hands
    end
    @winner
  end

  def compare_hands
    player_one_hand = @evaluated_hands['player_one']
    player_two_hand = @evaluated_hands['player_two']

    if player_one_hand['rank'] != 5
      @winner = highest_card_wins(player_one_hand['values'],player_two_hand['values'])
      if @winner == 0
        @winner = check_with_all_card_values
      end
    else
      @winner = check_with_all_card_values
    end
    @winner
  end

  def check_with_all_card_values
    player_one_values = @hand_one.cards.map(&:value).sort.reverse
    player_two_values = @hand_two.cards.map(&:value).sort.reverse
    highest_card_wins(player_one_values, player_two_values)
  end
  def print_hands_nicely
    puts "Hand one"
    @hand_one.cards.each { |card| puts "#{card.suit}#{card.value}\n"}

    puts "Hand two"
    @hand_two.cards.each { |card| puts "#{card.suit}#{card.value}\n"}
  end
end