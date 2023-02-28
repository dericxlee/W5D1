require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = self.bucket(key)
    list.include?(key)
  end

  def set(key, val)
    list = self.bucket(key)
    if list.include?(key)
      list.update(key,val)
    else 
      @count += 1
      if @count == self.num_buckets
        self.resize!
      end
      list.append(key,val)
    end
  end

  def get(key)
    if !self.include?(key)
      return nil
    end
    list = self.bucket(key)
    list.get(key)
  end

  def delete(key)
    list = self.bucket(key)
    @count -= 1
    list.remove(key)
  end

  def each(&prc)
    @store.each do |list|
      list.each do |node|
        prc.call([node.key,node.val])
      end
    end
    self
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end
  
  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    multi = 2*self.num_buckets
    empty = []
    multi.times do 
      empty << LinkedList.new() 
    end 
    @store.each do |list|
      list.each do |node|
        i = node.key.hash % empty.length
        empty[i].append(node.key,node.val)
      end
    end
    @store = empty
  end

  def bucket(key)
    i = key.hash % self.num_buckets
    @store[i]
  end
end