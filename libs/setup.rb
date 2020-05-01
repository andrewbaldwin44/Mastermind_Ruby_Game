def coder_or_breaker?
  coder_breaker = gets.chomp.downcase

  if coder_breaker == "breaker" || coder_breaker == "b"
    mode = player

    if mode.breaker_won?
      puts "#{"Congragulations! You guessed the code!".green_block}\n"
    else
      puts "#{"You lose! The code was: #{mode.code}".red_highlight} \n"
    end

  elsif coder_breaker == "coder" || coder_breaker == "c"
    mode, minimax = computer

    if mode.breaker_won?
      puts "#{"Uh oh! The computer broke your code in #{minimax.round + 1} rounds!".red_highlight}\n"
    else
      puts "#{"Wow! You won! The computer could not break your code!".green_highlight} \n"
    end

  else
    Validate.get_valid_coder_breaker
  end
end

def get_code_length
  length = gets.chomp.to_i

  length = Validate.get_valid_code_length unless (length >= 4 && length <= 8)
  length
end
