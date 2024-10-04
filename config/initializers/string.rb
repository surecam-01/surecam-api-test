class String
  def permutations
    self.chars.to_a.permutation.map(&:join)
  end
end