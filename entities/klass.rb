# frozen_string_literal: true

class Klass
  attr_accessor :id, :name

  PATH = './data/classes.txt'

  MENU_ITEMS = [
    'Добавить класс',
    'Редактировать класс',
    'Удалить класс'
  ].freeze

  def self.read_file(path = PATH)
    File.open(path, 'r:UTF-8') do |file|
      file.readlines.my_map do |line|
        arr = line.split(';')
        id = arr[0].to_i
        name = arr[1]&.strip
        Klass.new(id:, name:)
      end
    end
  end

  def self.all
    read_file
  end

  def self.show_klasses(items, user_input)
    item = items[user_input.to_i - 1]
    puts "Просмотр учеников класса #{item.name}"
    item
  end

  def self.add_class(name)
    index = line_index
    File.open(PATH, 'a:UTF-8') do |file|
      file.puts "#{index};#{name}"
    end
  end

  def self.line_index
    Klass.all.my_size == 0 ? 1 : Klass.all.my_size + 1
  end

  def self.edit_class(name, index)
    lines = File.readlines(PATH)
    lines[index - 1] = "#{index};#{name}\n"
    File.open(PATH, 'w:UTF-8') do |file|
      file.puts lines
    end
  end

  def self.delete_class(index)
    lines = File.readlines(PATH)
    lines.delete_at(index - 1)
    File.open(PATH, 'w:UTF-8') do |file|
      lines.my_each_with_index do |line, i|
        line = line.split(';')
        file.puts "#{i + 1};#{line[1]}"
      end
    end
  end

  def initialize(id:, name:)
    raise 'id не может быть 0 или меньше' if id <= 0

    @id = id
    @name = name
  end
end
