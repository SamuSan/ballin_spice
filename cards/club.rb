require_relative 'card.rb'

class Club < Card
  def initialize value
    super
    @suit = :c
  end
end