require 'set'
require_relative 'style'

class MinMaxAlgorithm
  def initialize(mastermind)
    @mastermind = mastermind

    @all_codes = COLORS.product(*[COLORS] * 3)
    @all_clues = Hash.new { |h, k| h[k] = {}}

    @all_codes.product(@all_codes).each do |colors, code|
      @best_colors = colors
      @code = code
      mastermind.colors = colors
      mastermind.code = code
      @all_clues[colors][code] = mastermind.check_code.gsub("\e[31m•\e[0m", "r")
    end

    @all_codes = @all_codes.to_set
  end

  public

  attr_reader :all_codes, :all_clues

  private

  attr_accessor :best_colors, :code
  attr_reader :mastermind, :possible_codes, :possible_clues, :round, :clue

  def calculate_guess
    if round > 0
      possible_codes.keep_if { |code| all_clues[best_colors][code] == clue}

      ordered_codes = possible_clues.map do |colors, clues_by_code|
          clues_by_code = clues_by_code.select { |code, clue|
            possible_codes.include?(code)
          }
          possible_clues[colors] = clues_by_code

          clue_groups = clues_by_code.values.group_by(&:itself)
          possibilty_counts = clue_groups.values.map(&:length)
          worst_case = possibilty_counts.max
          impossible_win = possible_codes.include?(colors) ? 0 : 1
          [worst_case, impossible_win, colors]
      end

      ordered_codes.min.last
    else
      %w[R R G G]
    end
  end

  public

  def play
    @possible_clues = all_clues.dup
    @possible_codes = all_codes.dup

    10.times do |round|
      @round = round

      self.best_colors = calculate_guess
      mastermind.colors = best_colors

      @clue = mastermind.check_code.gsub("\e[31m•\e[0m", "r")

      Display.display(best_colors)
      Display.give_clues(@clue)

      if mastermind.breaker_won?
        break
      end
    end
  end
end

def computer
  puts "\nAwesome! Now please just give the computer a minute to warm up!".blue_highlight

  mastermind = BreakerGameplay.new(nil, nil)
  minimax = MinMaxAlgorithm.new(mastermind)

  puts "\n#{"Alright mastermind, enter your secret code!(Your input will be invisible!)".purple_highlight}\n"

  user_code = get_user_code
  code_length = user_code.length

  mastermind.code = user_code
  mastermind.code_length = code_length

  puts "\nNice! The computer will now do it's best to crack your code".blue_highlight
  minimax.play
  mastermind
end

def get_user_code
  user_code = STDIN.noecho(&:gets).chomp.upcase.chars
  user_code = Validate.get_valid_user_code unless user_code.all?{ |color| COLORS.include?(color)} && \
                                      user_code.length  >= 4 && user_code.length <= 8
  user_code
end
