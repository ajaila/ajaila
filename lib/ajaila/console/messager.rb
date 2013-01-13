def build_block(text)
  output = "\nAjaila: " + text
#   %Q{
# #############################################################################
# #                                                                           # }
#   text.split("\n").each do |line|
#   	output += "\n#"+line.center(75)+"#"
#   end
#   output += %Q{
# #                                                                           #
# ############################################################################# }
  return output
end

def warning(text)
  build_block(text).color(Colors::WARNING)
end

def error(text)
  build_block(text).color(Colors::ERROR)
end


def info(text)
  build_block(text).color(Colors::INFO)
end

def success(text)
  build_block(text).color(Colors::SUCCESS)
end
