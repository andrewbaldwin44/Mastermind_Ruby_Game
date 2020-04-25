module Validate
  def get_valid_colors
    puts "\nWoah woah woah! Those are not the right colors! Lets try that agin".red_highlight
    puts "Please enter between 4 and 8 letters, each corresponding with a color"
    puts "For example, you could guess: 'RBCM'"
    self.get_guess
  end

  def self.get_valid_code_length
    puts "\nSorry! That didn't make any sense!".red_highlight
    puts "Please chose how many colors the code should be generated with."
    puts "Answer with '4', '5', '6', '7', or '8'."
    get_code_length
  end
end
