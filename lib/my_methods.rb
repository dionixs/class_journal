# frozen_string_literal: true

class Array
  def my_each
    i = 0

    while i < length
      yield self[i]
      i += 1
    end
  end

  def my_each_with_index
    i = 0

    while i < length
      yield(self[i], i)
      i += 1
    end
  end

  def my_map
    new_arr = []

    my_each do |item|
      new_arr << yield(item)
    end
    new_arr
  end

  def my_map_with_index
    new_arr = []

    my_each_with_index do |item, index|
      new_arr << yield(item, index)
    end
    new_arr
  end

  def my_size
    i = 0
    loop do
      break unless self[i]

      i += 1
    end
    i
  end

  def my_find_all
    i = 0
    new_arr = []

    while i < length
      new_arr << self[i] if yield(self[i])
      i += 1
    end
    new_arr
  end
end
