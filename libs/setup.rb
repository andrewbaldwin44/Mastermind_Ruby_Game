def coder_or_breaker?
  coder_breaker = gets.chomp.downcase

  if coder_breaker == "breaker" || coder_breaker == "b"
    player
  elsif coder_breaker == "coder" || coder_breaker == "c"
    puts "Hold up! We're not ready for that quite yet :/".purple_highlight
    computer
  else
    Validate.get_valid_coder_breaker
  end
end

def get_code_length
  length = gets.chomp.to_i

  length = Validate.get_valid_code_length unless (length >= 4 && length <= 8)
  length
end
