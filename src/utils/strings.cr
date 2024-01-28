module Strings
  def capitalize_words(input_string : String) : String
    capitalized_words = input_string.split(" ").map { |word| word.capitalize }
    capitalized_words.join(" ")
  end
end
