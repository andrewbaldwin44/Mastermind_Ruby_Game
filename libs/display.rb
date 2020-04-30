module Display
  def self.display(colors_string)
    colors = Display.colorize(colors_string)

    puts \
      "\n-----------------------------------------\n\n" \
      "#{colors.join(" ")}\n\n" \
  end

  def self.show_colors(colos)
    puts colos
  end

  def self.give_clues(clue)
    puts "#{clue}\n" \
         "\n-----------------------------------------\n\n"
  end

  def self.colorize(colors)
    colors.map { |color| COLOR_INPUT[color]}
  end
end
