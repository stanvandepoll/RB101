def balanced?(string)
  parentheses_nesting = 0

  string.chars.each do |char|
    return false if parentheses_nesting < 0

    if char == '('
      parentheses_nesting += 1
    elsif char == ')'
      parentheses_nesting -= 1
    end
  end

  parentheses_nesting == 0
end
