class MinMaxAlgorithm
  def initialize(mastermind)
    colors = "12345678".chars

    @mastermind = mastermind
    @mastermind.colors = %w[G G B B]

    #Create an array of every possible combination of answers (cartesian product)
    #Here the multiplication method takes the entire colors array as *args
    @all_answers = colors.product(*[colors] * 3).map(&:join)
    @all_scores = Hash.new { |h, k| h[k] = {}}

    #Each answer gets mapped to a potential score
    @all_answers.product(@all_answers).each do |guess, answer|
      @all_scores[guess][answer] = @mastermind.check_code
    end

    @all_answers.to_set
  end

  attr_reader :all_answers, :all_scores, :round
  attr_accessor :mastermind, :guess, :possible_scores, :possible_answers

  def play
    @guess = 0
    @possible_scores = @all_scores.dup
    @possible_answers = @all_answers.dup

    10.times do |round|
      puts "#{"Round #{round + 1} of 10".bold.underline}\n"

      @round = round
      @guess = make_guess

      mastermind.colors = [COLORS[@guess[0].to_i], COLORS[@guess[1].to_i], COLORS[@guess[2].to_i], COLORS[@guess[3].to_i]]
      @score = mastermind.check_code
      Display.display(mastermind.colors)
      Display.give_clues(mastermind.clue)
      break if mastermind.breaker_won?
    end
  end

  def calculate_score(guess, answer)
    score = ""
    wrong_guess_pegs, wrong_answer_pegs = [], []
    peg_pairs = guess.chars.zip(answer.chars)

    peg_pairs.each do |guess_peg, answer_peg|
      if guess_peg == answer_peg
        score << "B"
      else
        wrong_guess_pegs << guess_peg
        wrong_answer_pegs << answer_peg
      end
    end
    wrong_guess_pegs.each do |peg|
      if wrong_answer_pegs.include?(peg)
        wrong_answer_pegs.delete(peg)
        score << "W"
      end
    end

    score
  end

  def make_guess
    if round > 0
      possible_answers.keep_if { |answer| @all_scores[@guess][answer] == @score}

      guesses = possible_scores.map do |guess, scores_per_answer|
          scores_per_answer = scores_per_answer.select { |answer, score|
            possible_answers.include?(answer)
          }
          possible_scores[guess] = scores_per_answer

          score_groups = scores_per_answer.values.group_by(&:itself)
          possibilty_counts = score_groups.values.map(&:length)
          worst_case = possibilty_counts.max
          impossible_guess = possible_answers.include?(guess) ? 0 : 1

          #Heurestic Value
          [worst_case, impossible_guess, guess]
      end

      guesses.min.last #last because guess is last item in Heurestic
    else
      "1122"
    end
  end
end

def computer
  puts "\nAlright mastermind, enter your secret code!(Your input will be invisible!)".purple_highlight

  user_code = get_user_code
  code_length = user_code.length

  mastermind = BreakerGameplay.new(user_code, code_length)

  puts "\nNice! The computer will now do it's best to crack your code".blue_highlight
  puts "#{"Please give it a minute to warm up!".blue_highlight}\n\n"
  MinMaxAlgorithm.new(mastermind).play
  mastermind
end

# def computer
#   possible_colors = COLORS
#
#   last_clue = ""
#   last_guess = ""
#   best_guess = nil
#
#   10.times do |round|
#
#
#     if round == 0
#       guessed_colors = (possible_colors[0] * 2 + possible_colors[1] * 2).split("")
#       last_guess = guessed_colors
#       mastermind.colors = guessed_colors
#       mastermind.check_code
#       best_guess = MinMaxAlgorithm.new(mastermind)
#     else
#       best_guess.guess = "#{COLORS.index(last_guess[0])}#{COLORS.index(last_guess[1])}#{COLORS.index(last_guess[2])}#{COLORS.index(last_guess[3])}"
#       best_guess.compute(last_clue).chars.map(&:to_i)
#       p best_guess
#       best_colors = [COLORS[best_guess[0]], COLORS[best_guess[1]], COLORS[best_guess[2]], COLORS[best_guess[3]]]
#       p best_colors
#
#       mastermind.check_code
#       last_guess = best_colors
#     end
#
#
#     Display.display(mastermind.colors)
#     Display.give_clues(mastermind.clue)
#
#     clue = mastermind.clue.gsub("\e[31m•\e[0m", "r")
#     red_dots = clue.count("r")
#     white_dots = clue.count("•")
#
#     last_clue = clue
#     last_reds = red_dots
#     last_whites = white_dots
#
#     break if mastermind.breaker_won?
#   end
#   mastermind
# end

def get_user_code
  user_code = STDIN.noecho(&:gets).chomp.upcase.split("")
  user_code = Validate.get_valid_user_code unless user_code.all?{ |color| COLORS.include?(color)} && \
                                      user_code.length  >= 4 && user_code.length <= 8
  user_code
end
