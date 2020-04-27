class BreakerGameplay
  private

  include Display
  include Validate

  def initialize(code_length)
    @code_length = code_length
    @code = (1..code_length).map { COLORS[rand(8)] }
  end

  attr_accessor :code, :colors, :code_length

  public

  def get_guess
    @colors = gets.chomp.upcase.split("")
    self.get_valid_colors unless @colors.all?{ |color| COLORS.include?(color)} && \
                                 @colors.length == code_length
  end

  def check_code
    color_checker = colors.dup
    code_checker = code.dup

    correct_positions = 0
    correct_colors = 0

    color_checker.each_with_index do |color, index|
      if color_checker[index] == code_checker[index]
        correct_positions += 1
        color_checker[index] = nil
        code_checker[index] = nil
      end
    end

    color_checker.compact.each { |color| correct_colors += 1 if code_checker.compact.include?(color)}

    self.display(colors)
    self.give_clues("[#{"•"*correct_colors}#{"•".red*correct_positions}]")
  end

  def won_game?
    code == colors
  end

  def show_code
    puts "#{"You lose! The code was:".red_highlight} #{Display.colorize(code).join(" ")}"
  end
end
