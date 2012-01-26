class String
  def to_bool
    return true if self == true || self =~ (/t|y|1$/i)
    return false if self == false || self.blank? || self =~ (/f|n|0$/i)
    raise ArgumentError.new("Invalid value for boolean: \"#{self}\"")
  end
end
