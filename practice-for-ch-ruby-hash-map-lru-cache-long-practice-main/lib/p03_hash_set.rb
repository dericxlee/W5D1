class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    if self.include?(key)
      return false
    end
    @count += 1
    if @count == self.num_buckets
      self.resize!
    end
    # i = key.hash % self.num_buckets

    self[key] << key
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if !self.include?(key)
      return true
    end
    @count -= 1
    self[key].delete(key)
  end

  private

  def num_buckets
    @store.length
  end

  def resize!
    empty = []
    multiplier = num_buckets * 2
    multiplier.times do
      empty << Array.new()
    end

    @store.each do |bucket|
      bucket.each do |ele|
        i = ele.hash % empty.length
        empty[i] << ele
      end
    end
    return empty
  end

  def [](num)
    return @store[num.hash % self.num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end
end