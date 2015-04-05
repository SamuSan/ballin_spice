require_relative 'card.rb'

class Diamond < Card
  def initialize value
    super
    @suit = :d
  end
end