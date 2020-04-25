require "./libs/display"
require "./libs/style"
require "./libs/validate"
require "./libs/setup"

class BreakerGameplay
  private

  include Display
  include Validate

  COLORS = %w[R G B Y M C]

  def initialize(code_length)
    @code_length = code_length
    @code = (1..code_length).map { COLORS[rand(code_length)] }.join
  end

  attr_accessor :code, :colors, :code_length

  public

  def get_guess
    @colors = gets.chomp.upcase.gsub(/[^RGBYMC]/, "")
    self.get_valid_colors unless @colors.length == colors.length && colors.length == code_length
  end

  def check_code
    temp = @code.split("")

    correct_positions = 0
    correct_colors = 0

    colors.split("").each_with_index do |color, index|
      if temp[index] == colors[index]
        correct_positions += 1
        temp[index] = nil
      elsif temp.include?(color)
        correct_colors +=1
      end
    end

    self.display(colors)
    self.give_clues("[#{"•"*correct_colors}#{"•".red*correct_positions}]")
  end

  def won_game?
    if code == colors
      true
    end
  end

  def show_code
    puts "#{"You lose! The code was:".red_highlight} #{colorize(code).join(" ")}"
  end
end
