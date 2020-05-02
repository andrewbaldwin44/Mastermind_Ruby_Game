require 'set'
require_relative 'style'

class MinMaxAlgorithm
  def initialize(mastermind, possible_colors)
    @mastermind = mastermind

    #Using cartesian product, create an array of every possible combination of codes
    #Here the multiplication method accepts each possbile_colors array as *args
    @all_codes = possible_colors.product(*[possible_colors] * (mastermind.code_length - 1))
    @all_clues = Hash.new { |h, k| h[k] = {}}

    #With each possible code that the mastermind can create,
    #The code has a set amount of possible guesses that could be made towards it
    #We then calculate what the theoretical score would be for each match-up
    #and are thus able to create an array of all possible scores!
    #e.g. if we pretend the code was 'RGBY', then the matching guesses would be
    #'GBYR', 'MCRG', 'RRRR', etc. And each match would have a corresponding score
    @all_codes.product(@all_codes).each do |colors, code|
      @best_colors = colors
      @code = code
      mastermind.colors = colors
      mastermind.code = code

      #optimized: score for when code == colors is the same score for when colors == code
      #this score should only be taken into account once
      @all_clues[colors][code] = mastermind.calculate_clue unless @all_clues[colors][code]
    end

    @all_codes = @all_codes.to_set
  end

  public

  attr_reader :round
  attr_accessor :code

  private

  attr_accessor :best_colors
  attr_reader :mastermind, :all_codes, :all_clues, :possible_codes, :possible_clues, :clue

  def calculate_guess
    if round > 0
      #With each guess we can rule out code possibilities by checking the clue against the previous
      possible_codes.keep_if { |code| all_clues[best_colors][code] == clue}

      #Using the minimax algorithm logic, we can create an order of all posible color combinations
      #We do this using a heuristic value of the worst possible guess to make, an impossible guess (preferring a possible guess), and the color combination itself
      #The lowest heuristic value will be the best guess to make

      #The logic here is that there are 15 different combinations of clues that can be given by the code maker
      #but many color combinations could potentially receive the same clues
      #By this logic, the clue that would be given to the least amount of color combinations
      #would net us the most amount of information and therefore allow us to rule out the largest amount of possible codes
      ordered_codes = possible_clues.map do |code, clues_per_colors_map|
          #filter out codes no longer possible according to previous score
          clues_per_colors_map = clues_per_colors_map.select do |colors, clue|
            possible_codes.include?(colors)
          end
          #store the reduced map back into the possible clues
          possible_clues[code] = clues_per_colors_map

          clue_groups = clues_per_colors_map.values.group_by(&:itself) #group identical clues together -> gives us how many different responses the code maker could give
          possibilty_counts = clue_groups.values.map(&:length) #gives the amount of colors combination that would net the same clues
          worst_case = possibilty_counts.max #maximizing player -> which clue group could be netted by the most amount of color combinations -> would net the least information
          impossible_win = possible_codes.include?(code) ? 0 : 1 #a guess that could not possibly be the code may give us the most information as to what the code could be
          [worst_case, impossible_win, code] #heuristic value
      end

      #minimizing player
      ordered_codes.min.last #last corresponds to the colors in the heuristic
    else
      %w[R R G G] #the very best first guess to make according to Donald Kuth
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

      @clue = mastermind.calculate_clue

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

  puts "\n#{"Alright mastermind, enter your secret code!(Your input will be invisible!)".purple_highlight}\n"
  puts "\nThere are #{color_amount} colors to chose from: #{Display.colorize(possible_colors).join(" ")}"
  puts "\nYour secret code must be between 4 and #{color_amount} colors long."
  puts "Please keep in mind more colors means more thinking!".italic

  user_code = get_user_code
  code_length = user_code.length

  puts "\nPlease just give the computer a minute to warm up!".cyan_highlight.italic

  mastermind = BreakerGameplay.new(code_length)
  minimax = MinMaxAlgorithm.new(mastermind, possible_colors)

  mastermind.code = user_code
  mastermind.code_length = code_length
  minimax.code = user_code

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
