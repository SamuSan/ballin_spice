require_relative 'card.rb'

class Spade < Card
  def initialize value
  super
    @suit = :s
  end
end
