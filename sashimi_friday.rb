module SashimiFriday
  def all?(&block)
    each do |*item|
      return false unless pick(item, &block)
    end
    return true
  end

  def any?(&block)
    each do |*item|
      return true if pick(item, &block)
    end
    return false
  end

  def none?(&block)
    each do |*item|
      return false if pick(item, &block)
    end
    return true
  end

  def one?(&block)
    result = nil
    each do |*item|
      if pick(item, &block)
        case result
        when nil
          result = true
        when true
          return false
        end
      end
    end
    return false unless result
    return result
  end

  def chunk
  end

  def collect(&block)
    return enum_for(__method__) unless block
    results = []
    each do |*item|
      results << pick(item, &block)
    end
    return results
  end

  alias map collect

  def collect_concat
  end

  def count(*args, &block)
    found = 0
    case args.size
    when 0
      if block_given?
        each do |item|
          found += 1 if block.call(item)
        end
      else
        each do |item|
          found += 1
        end
      end
    when 1
      arg = args.first
      each do |item|
        found += 1 if item == arg
      end
    else
      raise ArgumentError
    end
    return found
  end

  def cycle(*args, &block)
    return enum_for(__method__, *args) unless block
    raise ArgumentError if args.size > 1
    n = args.first
    unless n.nil?
      begin
        n = Integer(n)
        return if n <= 0
      rescue
        raise TypeError
      end
    end
    ary = []
    each do |*item|
      item = pick(item)
      ary << item
      block.call(item)
    end
    return if ary.empty?
    (1...(n || Float::INFINITY)).each do
      ary.each do |item|
        block.call(item)
      end
    end
    return nil
  end

  def drop(n)
    results = []
    begin
      n = Integer(n)
    rescue
      raise TypeError
    end
    raise ArgumentError if n < 0
    each do |*item|
      next if (n = n.pred) >= 0
      results << pick(item)
    end
    return results
  end

  def take(n)
    results = []
    begin
      n = Integer(n)
    rescue
      raise TypeError
    end
    raise ArgumentError if n < 0
    return results if n.zero?
    each do |*item|
      item = pick(item)
      results << item
      break if (n = n.pred) <= 0
    end
    return results
  end

  def drop_while
  end

  def each_cons
  end

  def each_entry
  end

  def each_slice
  end

  def each_with_index
  end

  def each_with_object
  end

  def entries
  end

  def find(ifnone = nil, &block)
    return enum_for(__method__, ifnone) unless block
    each do |*item|
      item = pick(item)
      return item if block.call(item)
    end
    ifnone.call if ifnone
  end

  alias detect find

  def find_all(&block)
    return enum_for(__method__) unless block
    results = []
    each do |*item|
      item = pick(item)
      results << item if block.call(item)
    end
    return results
  end

  alias select find_all

  def find_index
  end

  def first
  end

  def flat_map
  end

  def grep(pattern)
    result = []
    each do |item|
      if pattern === item
        result << (block_given? ? yield(item) : item)
      end
    end
    return result
  end

  def group_by
  end

  def include?
  end

  def inject
  end

  def lazy
  end

  def max
  end

  def max_by
  end

  def member?
  end

  def min
  end

  def min_by
  end

  def minmax
  end

  def minmax_by
  end

  def partition
  end

  def reduce
  end

  def reject
  end

  def reverse_each
  end

  def slice_before
  end

  def sort
  end

  def sort_by
  end

  def take_while
  end

  def to_a
  end

  def zip
  end

  private

  def pick(item, &block)
    if block
      block.call(*item)
    else
      item.size == 1 ? item.first : item
    end
  end
end
