class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end

end

class LinkedList

  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    if self.empty?
      return false
    end

    @head.next
  end

  def last
    if self.empty?
      return false
    end

    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    if !self.include?(key)
      return nil
    end
    
    self.each do |node|
      if node.key == key
        return node.val
      end
    end
  end

  def include?(key)
    self.any? {|node| node.key == key}
  end

  def append(key, val)
    new_node = Node.new(key, val)
    @tail.prev.next = new_node
    new_node.prev = @tail.prev
    @tail.prev = new_node
    new_node.next = @tail
    return new_node
  end

  def update(key, val)
    if !self.include?(key)
      return false
    end

    self.each do |node|
      if node.key == key
        node.val = val
      end
    end
  end

  def remove(key)
    self.each do |node|
      if node.key == key
        prev_node = node.prev
        next_node = node.next
        prev_node.next = next_node
        next_node.prev = prev_node
      end
    end
  end

  def length
    count = 0
    start = @head.next
    until start.next == nil
      count += 1
      start = start.next
    end
    return count
  end

  def each(&prc)
    start = @head.next
    i = 0
    while i < self.length
      prc.call(start)
  
      i += 1
      start = start.next
    end
    return self
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end