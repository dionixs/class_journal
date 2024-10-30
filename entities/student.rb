# frozen_string_literal: true

class Student
  attr_accessor :first_name, :last_name, :middle_name, :id, :klass_id

  PATH = './data/students.txt'

  MENU_ITEMS = [
    'Добавить ученика',
    'Редактировать ученика',
    'Удалить ученика'
  ].freeze

  def self.read_file(path = PATH)
    File.open(path, 'r:UTF-8') do |file|
      file.readlines.my_map do |line|
        arr = line.split(';')
        id = arr[0].to_i
        last_name = arr[1]&.strip
        first_name = arr[2]&.strip
        middle_name = arr[3]&.strip
        klass_id = arr[4]&.to_i
        Student.new(id:, last_name:, first_name:, middle_name:, klass_id:)
      end
    end
  end

  def self.all
    read_file
  end

  def self.dict(klass_id = nil)
    hh = {}
    Student.all.my_each do |item|
      if klass_id
        hh[item.id] = item if item.klass_id == klass_id
      else
        hh[item.id] = item
      end
    end
    hh
  end

  def self.add_student(full_name, klass_id)
    readlines_size = File.open(PATH, 'r:UTF-8') do |file|
      file.readlines.my_size
    end
    full_name = full_name.split(' ')
    index = readlines_size == 0 ? 1 : readlines_size + 1
    File.open(PATH, 'a:UTF-8') do |file|
      file.puts "#{index};#{full_name[0]};#{full_name[1]};#{full_name[2]};#{klass_id}"
    end
  end

  def self.edit(item, new_name = nil, delete = false)
    full_name = new_name.split(' ') if new_name
    lines = File.open(PATH, 'r:UTF-8') do |file|
      file.readlines.my_map do |line|
        arr = line.split(';')
        id = arr[0].to_i
        if delete == true
          line if item.id != id
        elsif item.id == id
          "#{id};#{full_name[0]};#{full_name[1]};#{full_name[2]};#{item.klass_id}\n"
        else
          line
        end
      end.my_find_all { |item| !item.nil? }
    end
    File.open(PATH, 'w:UTF-8') do |file|
      lines.my_each_with_index do |line, index|
        arr = line.split(';')
        last_name = arr[1]&.strip
        first_name = arr[2]&.strip
        middle_name = arr[3]&.strip
        klass_id = arr[4]&.to_i
        file.puts "#{index + 1};#{last_name};#{first_name};#{middle_name};#{klass_id}\n"
      end
    end
  end

  def self.delete(item)
    Student.edit(item, nil, true)
  end

  def initialize(id:, last_name:, first_name:, middle_name:, klass_id:)
    raise 'id не может быть 0 или меньше' if id <= 0
    raise 'klass_id не может быть 0 или меньше' if klass_id <= 0

    @id = id
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
    @klass_id = klass_id
  end

  def full_name
    "#{last_name} #{first_name} #{middle_name}"
  end
end
