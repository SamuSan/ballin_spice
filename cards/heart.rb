require_relative 'card.rb'

class Heart < Card
  def initialize value
    super
    @suit = :h
  end
end
