module Rules
  def self.show_rules?
    show_rules = gets.chomp.downcase

    if show_rules == "no" || show_rules == "n"
      self.rules
    elsif show_rules == "yes" || show_rules == "y"
      puts "\nAwesome! Then you'll know what to do! :)".green_highlight
    else
      Validate.get_valid_rules
    end
  end

  def self.rules
    puts "Here are the game rules"
  end
end
