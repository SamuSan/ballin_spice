class EvaluateHands
  def initialize(player_one_hand, player_two_hand)
    @player_one_hand = player_one_hand
    @player_two_hand = player_two_hand
  end

  def call
    hand_one_eval = evaluate_cards @player_one_hand

    { 'player_one' => hand_one_eval, 'player_two' => "sucks" }
  end

  private

  def evaluate_cards hand
    royal_flush hand
  end

  def one_pair hand
    evaluated_cards = tally_value_frequency(hand).select  { |k,v| v == 2 }

    if evaluated_cards.length == 1
      { 'one_pair' => evaluated_cards.keys, 'rank' => 1 }
    end
  end

  def two_pair hand
    evaluated_cards = tally_value_frequency(hand).select  { |k,v| v == 2 }

    if evaluated_cards.length == 2
      { 'two_pair' => evaluated_cards.keys, 'rank' => 2 }
    else
      one_pair hand
    end
  end

  def three_of_a_kind hand
    evaluated_cards = tally_value_frequency(hand).select  { |k,v| v == 3 }

    if evaluated_cards.length == 1
      { 'three_of_a_kind' => evaluated_cards.keys, 'rank' => 3 }
    else
      two_pair hand
    end
  end

  def three_of_a_kind? hand
    tally_value_frequency(hand).select  { |k,v| v == 3 }.any?
  end

  def straight hand
    values = collect_values hand
      if straight? values
        { 'straight' => [values[0]], 'rank' => 4}
      else
        three_of_a_kind hand
      end
  end

  def straight? values
     values[1] == values[0]+1 &&
          values[2] == values[1]+1 &&
            values[3] == values[2]+1 &&
              values[4] == values[3]+1
  end

  def flush hand
    if flush? collect_suits hand
      { 'flush' => [collect_suits(hand).first], 'rank' => 5 }
    else
      straight hand
    end
  end

  def flush? suits
    suits.uniq.length == 1
  end

  def full_house hand
    if three_of_a_kind? hand
      if collect_values(hand).uniq.length == 2
        { 'full_house' => collect_values(hand).uniq, 'rank' => 6 }
      else
        flush hand
      end
    else
      flush hand
    end
  end

  def four_of_a_kind hand
    evaluated_cards = tally_value_frequency(hand).select  { |k,v| v == 4 }
    if evaluated_cards.length == 1
      { 'four_of_a_kind' => evaluated_cards.keys, 'rank' => 7 }
    else
      full_house hand
    end
  end

  def straight_flush hand
    if straight? collect_values hand
      if flush? collect_suits hand
        value = collect_values(hand)[0]
        suit = collect_suits(hand)[0]
        { 'straight_flush' => [suit, value], 'rank' => 8 }
      else
        four_of_a_kind hand
      end
    else
      four_of_a_kind hand
    end
  end

  def royal_flush hand
    value_order = collect_values(hand).sort
    if value_order.first == 10 && collect_suits(hand).uniq.length == 1
      { 'royal_flush' => collect_suits(hand).uniq, 'rank' => 9 }
    else
      straight_flush hand
    end
  end

  def tally_value_frequency hand
    counts = Hash.new(0)
    hand.cards.map(&:value).each { |value| counts[value] += 1 }
    counts
  end

  def collect_values hand
    hand.cards.map(&:value)
  end

  def collect_suits hand
    hand.cards.map(&:suit)
  end
end