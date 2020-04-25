require "./libs/rules"
require "./libs/setup"
require "./libs/breaker_gameplay"
require "./libs/style"


puts "\nWelcome! Let's play a game of Mastermind!".bg_blue

Rules.show_rules?

loop do
  puts "\nWould you like to be the #{"coder".underline.bold}(c) or #{"breaker".underline.bold}(b)?"

  mastermind = coder_or_breaker?

  puts "\n\n-----------------------------------------------------\n\n\n"
  10.times do |round|
    puts "Round #{round+1} of 10".bold.underline
    puts "\nThere are 8 colors to chose from: #{%w[R G B Y M C W].map{ |color| COLOR_INPUT[color]}.join(" ")}"
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
