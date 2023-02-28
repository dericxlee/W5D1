require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :store, :map

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if !@map.include?(key)
      val = @prc.call(key)
      if @max == self.count
        self.eject!
        self.calc!(key, val)
        return val
      else
        self.calc!(key, val)
        return val
      end
    else
      node = @map[key]
      self.update_node!(node)
      return node.val
    end
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key, val)
    new_node = @store.append(key, val)
    @map[key] = new_node
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    @store.remove(node.key)
    new_node = @store.append(node.key, node.val)
    @map[node.key] = new_node
    # suggested helper method; move a node to the end of the list
  end

  # def append(node)
  #   prev_node = node.prev
  #   next_node = node.next

  # end

  def eject!
    node1 = @store.first
    node2 = node1.next
    node2.prev = @store.head
    @store.head.next = node2
    @map.delete(node1.key)
    return true
  end
end