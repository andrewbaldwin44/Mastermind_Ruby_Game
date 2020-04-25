module Rules
  def self.show_rules?
    puts "\nHave you ever played before?(yes/no)"

    show_rules = gets.chomp.downcase

    if show_rules == "no" || show_rules == "n"
      self.rules
    elsif show_rules == "yes" || show_rules == "y"
      puts "\nAwesome! Then you'll know what to do! :)".green_highlight
    else
      get_valid_rules
    end
  end

  def self.get_valid_rules
    puts "\nWell that wasn't much of an answer!".red_highlight
    puts "Please answer 'yes' to see the rules or 'no' to start the game!"
    self.show_rules?
  end


  def self.rules
    puts "Here are the game rules"
  end
end
