def block_word?(word)
  available_blocks = %w[bo gt vi xk re ly dq fs zm cp jw na hu]

  word.chars.each do |char|
    char.downcase!
    return false unless available_blocks.any? { |block| block.include?(char) }

    available_blocks.reject! { |block| block.include?(char) }
  end

  true
end
