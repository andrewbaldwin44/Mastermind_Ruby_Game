require_relative "libs/style"
require_relative "libs/display"
require_relative "libs/validate"
require_relative "libs/rules"
require_relative "libs/setup"
require_relative "libs/player"
require_relative "libs/computer"
require_relative "libs/breaker_gameplay"

COLORS = %w[R G B Y M C W K]

puts "\nWelcome! Let's play a game of Mastermind!".bg_blue
puts "\nHave you ever played before?(yes/no)"
Rules.show_rules?

loop do
  puts "\nWould you like to be the #{"coder".underline.bold}(c) or #{"breaker".underline.bold}(b)?"

  coder_or_breaker?

  puts "\nWould you like to play again?(yes/no)"
  replay = gets.chomp
  break unless replay == "yes" || replay == "y"
end

puts "\nHave a nice day! :)".green_highlight
