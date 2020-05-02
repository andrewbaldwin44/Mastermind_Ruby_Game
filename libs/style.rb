class String
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end

  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end

  def blue_block;    "\e[44m  #{self}  \e[0m" end
  def green_block;   "\e[42m  #{self}  \e[0m" end
  def magenta_block; "\e[45m  #{self}  \e[0m" end
  def cyan_block;    "\e[46m  #{self}  \e[0m" end
  def yellow_block;  "\e[43m  #{self}  \e[0m" end
  def red_block;     "\e[41m  #{self}  \e[0m" end
  def white_block;   "\e[30m\e[47m  #{self}  \e[0m" end
  def black_block;   "\e[31m\e[40m  #{self}  \e[0m" end

  def cyan_highlight;     "\e[1;36;40m#{self}\e[0m" end
  def purple_highlight;   "\e[1;35;40m#{self}\e[0m" end
  def red_highlight;      "\e[1;31;40m#{self}\e[0m" end
  def green_highlight;    "\e[1;32;40m#{self}\e[0m" end
  def yellow_highlight;   "\e[1;33;40m#{self}\e[0m" end
  def blue_highlight;     "\e[1;34;40m#{self}\e[0m" end
end

COLOR_INPUT = {
  "R" => "R".red_block,
  "G" => "G".green_block,
  "B" => "B".blue_block,
  "Y" => "Y".yellow_block,
  "M" => "M".magenta_block,
  "C" => "C".cyan_block,
  "W" => "W".white_block,
  "K" => "K".black_block
}
