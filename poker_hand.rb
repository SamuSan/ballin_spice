require_relative 'cards/club.rb'
require_relative 'cards/heart.rb'
require_relative 'cards/diamond.rb'
require_relative 'cards/spade.rb'

class PokerHand
  attr_reader :cards

  SUITS = {   "S" => "Spade",
              "C" => "Club",
              "H" => "Heart",
              "D" => "Diamond" }

  VALUES = {  "T" => 10,
              "J" => 11,
              "Q" => 12,
              "K" => 13,
              "A" => 14 }

  def initialize(card_list)
    @cards = []
    construct_cards(card_list)
  end

  def rank_hand

  end

  private

  def construct_cards(card_list)
    card_list.each { |card|
      value = convert_card_value card[0]
      @cards <<  Module.const_get(SUITS[card[1]]).new(value)
    }
  end

  def convert_card_value value
    if is_face_card? value
      value = VALUES[value].to_i
    else
      value = value.to_i
    end
  value
  end

  def is_face_card? value
    ("A".."Z").include? value
  end
end


