def player
  puts "\nSweet! And how many colors should the code contain?(4, 5, 6, 7, 8)".yellow_highlight

  code_length = get_code_length

  puts "\nAlright! The computer has created a top secret code!"
  puts "Get cracking!"

  mastermind = BreakerGameplay.new(code_length)

  puts "\n\n-----------------------------------------------------\n\n\n"

  10.times do |round|
    puts "Round #{round+1} of 10".bold.underline
    puts "\nThere are 8 colors to chose from: #{Display.colorize(COLORS).join(" ")}"
    puts "Make your guess in the form of '#{COLORS.take(code_length).join("")}'"

    mastermind.get_guess
    mastermind.check_code

    if mastermind.won_game?
      puts "#{"Congragulations! You guessed the code!".green_block}\n"
      break
    end
  end

  mastermind.show_code unless mastermind.won_game?
end
