require 'set'
require_relative 'style'

class MinMaxAlgorithm
  def initialize(mastermind, possible_colors)
    @mastermind = mastermind

    @all_codes = possible_colors.product(*[possible_colors] * 3)
    @all_clues = Hash.new { |h, k| h[k] = {}}

    @all_codes.product(@all_codes).each do |colors, code|
      @best_colors = colors
      @code = code
      mastermind.colors = colors
      mastermind.code = code
      @all_clues[colors][code] = mastermind.check_code
    end

    @all_codes = @all_codes.to_set
  end

  public

  attr_reader :round

  private

  attr_accessor :best_colors, :code
  attr_reader :mastermind, :all_codes, :all_clues, :possible_codes, :possible_clues, :clue

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
      puts "Round #{round+1} of 10".bold.underline
      @round = round

      self.best_colors = calculate_guess
      mastermind.colors = best_colors

      @clue = mastermind.check_code

      Display.display(best_colors)
      Display.give_clues(@clue)

      if mastermind.breaker_won?
        break
      end
    end
  end
end

def computer
  puts "\nHow many possible colors should there be?(6, 7, 8)".yellow_highlight
  puts "You should expect a longer thinking time for anything above 6!".italic

  color_amount = get_possible_colors
  possible_colors = COLORS[0, color_amount]

  puts "\nPlease just give the computer a minute to warm up!".cyan_highlight.italic

  mastermind ||= BreakerGameplay.new(nil, nil)
  minimax ||= MinMaxAlgorithm.new(mastermind, possible_colors)

  puts "\n#{"Alright mastermind, enter your secret code!(Your input will be invisible!)".purple_highlight}\n"
  puts "\nThere are #{color_amount} colors to chose from: #{Display.colorize(possible_colors).join(" ")}"

  user_code = get_user_code
  code_length = user_code.length

  mastermind.code = user_code
  mastermind.code_length = code_length

  puts "\n#{"Nice! The computer will now do it's best to crack your code".blue_highlight}\n\n"
  minimax.play
  return mastermind, minimax
end

def get_possible_colors
  color_amount = gets.chomp.to_i
  color_amount = Validate.get_valid_possible_colors unless color_amount >= 6 && color_amount <= 8
  color_amount
end

def get_user_code
  user_code = STDIN.noecho(&:gets).chomp.upcase.chars
  user_code = Validate.get_valid_user_code unless user_code.all?{ |color| COLORS.include?(color)} && \
                                                  user_code.length  >= 4 && user_code.length <= 8
  user_code
end
