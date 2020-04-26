require_relative "libs/style"
require_relative "libs/display"
require_relative "libs/validate"
require_relative "libs/rules"
require_relative "libs/setup"
require_relative "libs/breaker_gameplay"

puts "\nWelcome! Let's play a game of Mastermind!".bg_blue
puts "\nHave you ever played before?(yes/no)"
Rules.show_rules?

loop do
  puts "\nWould you like to be the #{"coder".underline.bold}(c) or #{"breaker".underline.bold}(b)?"

  mastermind = coder_or_breaker?

  puts "\n\n-----------------------------------------------------\n\n\n"

  10.times do |round|
    puts "Round #{round+1} of 10".bold.underline
    puts "\nThere are 8 colors to chose from: #{Display.colorize("RGBYMCWK".split("")).join(" ")}"
    puts "Make your guess in the form of 'RGBY'"

    mastermind.get_guess
    mastermind.check_code

    if mastermind.won_game?
      puts "#{"Congragulations! You guessed the code!".green_block}\n"
      break
    end
  end

  mastermind.show_code unless mastermind.won_game?

  puts "\nWould you like to play again?(yes/no)"
  replay = gets.chomp
  break unless replay == "yes" || replay == "y"
end

puts "\nHave a nice day! :)".green_highlight
