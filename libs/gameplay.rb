require "./libs/display"
require "./libs/style"

class Gameplay
  include Display

  def initialize
    @guesses = []
  end

  attr_accessor :guesses

  def show_board(colors)
    guesses << colors
    guesses.each { |guess| self.display(guess)}
  end
end
