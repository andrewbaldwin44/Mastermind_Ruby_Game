def player
  puts "\nSweet! And how many colors should the code contain?(4, 5, 6, 7, 8)".yellow_highlight

  code_length = get_code_length
  code = (1..code_length).map { COLORS[rand(8)] }

  puts "\nAlright! The computer has created a top secret code!"
  puts "Get cracking!"

  mastermind = BreakerGameplay.new(code, code_length)

  puts "\n\n-----------------------------------------------------\n\n\n"

  10.times do |round|
    puts "Round #{round+1} of 10".bold.underline
    puts "\nThere are 8 colors to chose from: #{Display.colorize(COLORS).join(" ")}"
    puts "Make your guess in the form of '#{COLORS.take(code_length).join("")}'"

    mastermind.get_guess
    mastermind.check_code

    Display.display(mastermind.colors)
    Display.give_clues(mastermind.clue)

    break if mastermind.breaker_won?
  end
  mastermind
end
