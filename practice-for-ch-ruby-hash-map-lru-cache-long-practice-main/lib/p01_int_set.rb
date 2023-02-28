class MaxIntSet
  attr_reader :max, :store
  def initialize(max)
    @store = Array.new(max + 1)
    @max = max
  end

  def insert(num)
    if num > self.max || num < 0
      raise 'Out of bounds'
    elsif self.include?(num)
      return false
    else
      @store[num] = true
    end
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num] == true
  end

  private

  def is_valid?(num)
  end

  def validate!(num)
  end
end

class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    num_buckets = @store.length

    i = num % num_buckets
    if self.include?(num)
      return false
    else
      @store[i] << num
    end
  end

  def remove(num)
    num_buckets = @store.length
    i = num % num_buckets

    if self.include?(num)
      @store[i].delete(num)
    end
  end

  def include?(num)
    @store.each do |bucket|
      bucket.each do |n|
        return true if num == n
      end
    end
    return false
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if self.include?(num)
      return false 
    end
    @count += 1
    if @count >= self.num_buckets
      self.resize!
    end
    i = num % self.num_buckets
    @store[i] << num
  end

  def remove(num)
    if !self.include?(num)
      return false 
    end 
    i = num % self.num_buckets
    @count -= 1
    @store[i].delete(num)
  end

  def include?(num)
    i = num % self.num_buckets
    @store[i].include?(num)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    # Assume count is 20 and store.length is 20. 
    multiplier = self.num_buckets*2
    empty = []
    multiplier.times do |i|
      empty << Array.new()
    end
    @store.each do |bucket|
      bucket.each do |num|
        i = num % empty.length
        empty[i] << num 
      end
    end
    @store = empty        
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end
end