def real_palindrome?(string)
  string = string.downcase.tr('^a-z0-9', '')
  string == string.reverse
end
