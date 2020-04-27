module Rules
  def self.show_rules?
    show_rules = gets.chomp.downcase

    if show_rules == "no" || show_rules == "n"
      puts self.rules
    elsif show_rules == "yes" || show_rules == "y"
      puts "\nAwesome! Then you'll know what to do! :)".green_highlight
    else
      Validate.get_valid_rules
    end
  end

  def self.rules
    <<~HEREDOC

      #{"Let's Learn How to Play!".bold.underline}

        There are two roles in this game:

        #{"The Maker".underline.purple_highlight}

          The maker doesn't have much to do! They simply have to create a code!

          The code:
            - Must be between 4 and 8 colors long
            - Must use: #{Display.colorize("RGBYMCWK".split("")).join(" ")}
            - #{"Can".bold.italic} contain duplicates
            - The breaker knows how long the code is!

        #{"The Breaker".underline.red_highlight}

          The breaker must use wits and strategy to break the code!
          With each guess that the breaker makes, hints are given as to how close their guess was!

            -> A white dot [•] is given for each #{"correctly guessed color".italic} that was put in the #{"wrong position!".italic}

                #{"For example:".italic.yellow_highlight}

                  - The #{"master code".italic.purple_highlight} is:            #{Display.colorize("RGBY".split("")).join(" ")}

                  - The breaker's guess is:        #{Display.colorize("GMCR".split("")).join(" ")}

                  - The breaker's clues would be:  [••]

                    #{"That's one white dot for each correctly guessed color (".italic}#{"green".green.italic} #{"and".italic} #{"red".red.italic} #{"in this case)".italic}
                    #{"But they're not in the right position!".italic}


            -> A red dot [#{"•".red}] is given for each #{"correctly guessed color".italic} that's in the #{"right position!".italic}

                #{"Continuing the example above:".italic.yellow_highlight}

                  - The breaker's guess is:       #{Display.colorize("RCMR".split("")).join(" ")}

                  - The breaker's clue would be:  [#{"•".red}]

                    #{"That's one red dot for a correctly guessed and correctly positioned color (".italic}#{"red".red.italic} #{"in this case)".italic}

                #{"Putting in all together:".italic.yellow_highlight}

                  - The breaker's guess is:       #{Display.colorize("RYGB".split("")).join(" ")}

                  - The breaker's clue would be:  [#{"•"*3}#{"•".red}]

        If the breaker cracks the code, they win! Otherwise, the maker wins!
        With that said...
    HEREDOC
  end
end
