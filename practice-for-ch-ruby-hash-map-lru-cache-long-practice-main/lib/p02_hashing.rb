class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    num = 0
    self.each_with_index do |ele,idx|
      num += (ele*idx).hash
    end
    num
  end
end

class String
  def hash
    target = 0
    alphabet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    alpha_bet = alphabet.split("")
    letters = self.split("")
    letters.each_with_index do |char,idx|
      num = alpha_bet.index(char) * idx
      target += num.hash
    end
    target 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    arry = []
    self.each do |k,v|
      arry << k.hash
    end
    arry.sum
  end
end
