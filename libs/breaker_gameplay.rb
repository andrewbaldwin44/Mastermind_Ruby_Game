class BreakerGameplay
  private

  include Display
  include Validate

  def initialize(code, code_length)
    @code_length = code_length
    @code = code
  end

  attr_accessor :code, :code_length

  public

  attr_accessor :colors
  attr_reader :code, :clue, :breaker_won

  def get_guess
    @colors = gets.chomp.upcase.split("")
    get_valid_colors unless @colors.all?{ |color| COLORS.include?(color)} && \
                            @colors.length == code_length
  end

  def check_code
    color_checker = colors.dup
    code_checker = code.dup

    # puts "code: #{code}"
    # puts "code_checker: #{code_checker}"

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
    @clue = "[#{"•"*correct_colors}#{"•".red*correct_positions}]"
  end

  def breaker_won?
    code == colors
  end

  def show_code
    puts Display.colorize(code).join(" ")
  end
end
