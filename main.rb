require "./libs/gameplay"
require "./libs/style"

mastermind = Gameplay.new

puts "\nWelcome! Let's play a game of Mastermind!".bg_blue
puts "\nHave you ever played before?(y/n)"

play_game = true

user_colors = gets.chomp

mastermind.show_board(user_colors)
