def coder_or_breaker?
  coder_breaker = gets.chomp.downcase

  if coder_breaker == "breaker" || coder_breaker == "b"
    puts "\nSweet! And how many colors should the code contain?(4, 5, 6, 7, 8)".yellow_highlight

    code_length = get_code_length

    puts "\nAlright! The computer has created a top secret code!"
    puts "Get cracking!"

    BreakerGameplay.new(code_length)

  elsif coder_breaker == "coder" || coder_breaker == "c"
    puts "Hold up! We're not ready for that quite yet :/".purple_highlight

  else
    Validate.get_valid_coder_breaker
  end
end

def get_code_length
  length = gets.chomp.to_i

  length = Validate.get_valid_code_length unless (length >= 4 && length <= 8)
  length
end
