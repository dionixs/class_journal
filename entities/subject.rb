# frozen_string_literal: true

class Subject
  extend Statistics

  attr_accessor :name, :id, :klass_id

  PATH = './data/subjects.txt'

  MENU_ITEMS = [
    'Добавить предмет',
    'Редактировать предмет',
    'Удалить предмет',
    'Назад'
  ].freeze

  def self.read_file(path = PATH)
    File.open(path, 'r:UTF-8') do |file|
      file.readlines.my_map do |line|
        arr = line.split(';')
        id = arr[0].to_i
        name = arr[1]&.strip
        klass_id = arr[2].to_i
        Subject.new(id:, name:, klass_id:)
      end
    end
  end

  def self.all
    read_file
  end

  def self.dict(klass_id = nil)
    hh = {}
    Subject.all.my_each do |item|
      if klass_id
        hh[item.id] = item if item.klass_id == klass_id
      else
        hh[item.id] = item
      end
    end
    hh
  end

  def self.add(name, klass_id)
    readlines_size = File.open(PATH, 'r:UTF-8') do |file|
      file.readlines.my_size
    end
    index = readlines_size == 0 ? 1 : readlines_size + 1
    File.open(PATH, 'a:UTF-8') do |file|
      file.puts "#{index};#{name};#{klass_id}"
    end
  end

  def self.edit(item, new_name = nil, delete = false)
    lines = File.open(PATH, 'r:UTF-8') do |file|
      file.readlines.my_map do |line|
        arr = line.split(';')
        id = arr[0].to_i
        return_line(item, new_name, id, delete, line)
      end
    end
    write_lines(lines.my_find_all { |item| !item.nil? })
  end

  def self.write_lines(lines)
    File.open(PATH, 'w:UTF-8') do |file|
      lines.my_each_with_index do |line, index|
        arr = line.split(';')
        name = arr[1]&.strip
        klass_id = arr[2]&.to_i
        file.puts "#{index + 1};#{name};#{klass_id}\n"
      end
    end
  end

  def self.return_line(item, new_name, id, delete, line)
    if delete == true
      line if item.id != id
    elsif item.id == id
      "#{id};#{new_name};#{item.klass_id}\n"
    else
      line
    end
  end

  def self.delete(item)
    Subject.edit(item, nil, true)
  end

  def initialize(id:, name:, klass_id:)
    raise 'id не может быть 0 или меньше' if id <= 0
    raise 'klass_id не может быть 0 или меньше' if klass_id <= 0

    @id = id
    @name = name
    @klass_id = klass_id
  end
end
