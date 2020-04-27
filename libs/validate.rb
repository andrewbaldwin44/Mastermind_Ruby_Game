module Validate
  def self.get_valid_rules
    puts "\nWell that wasn't much of an answer!".red_highlight
    puts "Please answer '#{"yes".bold.underline}' to see the rules or '#{"no".bold.underline}' to start the game!"

    show_rules = gets.chomp.downcase
    if show_rules == "yes" || show_rules == "y"
      puts Rules.rules
    elsif show_rules == "no" || show_rules == "n"
      puts "\nLet's get started!"
    else
      self.get_valid_rules
    end
  end

  def self.get_valid_coder_breaker
    puts "\nHmmmmmm... Nope that doesn't make any sense!".red_highlight
    puts \
      "Please answer with: #{"coder".bold.underline}(c) or #{"breaker".bold.underline}(b)" \
      "\nThe coder #{"makes".italic} the code to be broken while the breaker tries to #{"break".italic} the code!"
    coder_or_breaker?
  end

  def self.get_valid_code_length
    puts "\nSorry! That didn't make any sense!".red_highlight
    puts "Please chose how many colors the code should be generated with."
    puts "Answer with #{(4..7).map{ |number| "'#{number.to_s.bold}'"}.join(", ")}, or '#{"8".bold}'."

    get_code_length
  end

  def get_valid_colors
    puts "\nWoah woah woah! Those are not the right colors! Lets try that agin".red_highlight
    puts "Please enter #{code_length} letters, each corresponding with a color"
    puts "For example, you could guess: 'RBCM'"
    self.get_guess
  end
end
