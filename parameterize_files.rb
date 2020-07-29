def parameterize(string, separator: "-", preserve_case: false)
  # Replace accented chars with their ASCII equivalents.
  parameterized_string = string.downcase

  # Turn unwanted chars into the separator.
  parameterized_string.gsub!(/[^a-z0-9\-_]+/, separator)

  unless separator.nil? || separator.empty?
    if separator == "-".freeze
      re_duplicate_separator        = /-{2,}/
      re_leading_trailing_separator = /^-|-$/
    else
      re_sep = Regexp.escape(separator)
      re_duplicate_separator        = /#{re_sep}{2,}/
      re_leading_trailing_separator = /^#{re_sep}|#{re_sep}$/
    end
    # No more than one of the separator in a row.
    parameterized_string.gsub!(re_duplicate_separator, separator)
    # Remove leading/trailing separator.
    parameterized_string.gsub!(re_leading_trailing_separator, "".freeze)
  end

  parameterized_string.downcase! unless preserve_case
  parameterized_string
end


folder_path = "./src/"
Dir.glob(folder_path + "*").sort.each do |f|
  filename = File.basename(f, File.extname(f))
  clean = parameterize(filename)
  new_state = folder_path + clean + File.extname(f)
  puts "#{f.rjust(37, " ")}  ===>  #{new_state}"
  File.rename(f, new_state)
end
