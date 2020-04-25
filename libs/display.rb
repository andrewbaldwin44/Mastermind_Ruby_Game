require "./libs/style"

module Display
  def display(colors_string)
    colors = colorize(colors_string)

    puts display =
      "\n-----------------------------------------\n\n" \
      "#{colors.join(" ")}\n\n" \
  end

  def give_clues(clue)
    puts "#{clue}\n" \
         "\n-----------------------------------------\n\n"
  end

  def colorize(colors)
    colors.split("").map { |color| COLOR_INPUT[color]}
  end
end
