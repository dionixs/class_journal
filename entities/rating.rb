# frozen_string_literal: true

class Rating

  attr_accessor :grade, :id, :subject_id, :student_id

  PATH = './data/ratings.txt'

  MENU_ITEMS = [
    'Добавить оценку',
    'Редактировать оценку',
    'Удалить оценку',
    'Назад'
  ].freeze

  def self.read_file(path = PATH)
    File.open(path, 'r:UTF-8') do |file|
      file.readlines.my_map do |line|
        arr = line.split(';')
        id = arr[0].to_i
        grade = arr[1].to_i
        subject_id = arr[2].to_i
        student_id = arr[3].to_i
        Rating.new(id:, grade:, subject_id:, student_id:)
      end
    end
  end

  def self.all
    read_file
  end

  def self.dict(subject_id = nil, student_id = nil)
    hh = {}
    Rating.all.my_each do |item|
      if subject_id && student_id
        hh[item.id] = item if item.subject_id == subject_id && item.student_id == student_id
      else
        hh[item.id] = item
      end
    end
    hh
  end

  def self.add(grade, subject_id, student_id)
    readlines_size = File.open(PATH, 'r:UTF-8') do |file|
      file.readlines.my_size
    end
    index = readlines_size == 0 ? 1 : readlines_size + 1
    File.open(PATH, 'a:UTF-8') do |file|
      file.puts "#{index};#{grade};#{subject_id};#{student_id}"
    end
  end

  def self.edit(item, new_grade = nil, delete = false)
    lines = File.open(PATH, 'r:UTF-8') do |file|
      file.readlines.my_map do |line|
        arr = line.split(';')
        id = arr[0].to_i
        if delete == true
          line if item.id != id
        elsif item.id == id
          "#{id};#{new_grade};#{item.subject_id};#{item.student_id}"
        else
          line
        end
      end.my_find_all { |item| !item.nil? }
    end
    File.open(PATH, 'w:UTF-8') do |file|
      lines.my_each_with_index do |line, index|
        arr = line.split(';')
        grade = arr[1].to_i
        subject_id = arr[2].to_i
        student_id = arr[3].to_i
        file.puts "#{index + 1};#{grade};#{subject_id};#{student_id}"
      end
    end
  end

  def self.delete(item)
    Rating.edit(item, nil, true)
  end

  def initialize(id:, grade:, subject_id:, student_id:)
    raise 'id не может быть 0 или меньше' if id <= 0
    raise 'subject_id не может быть 0 или меньше' if subject_id <= 0
    raise 'student_id не может быть 0 или меньше' if student_id <= 0

    @id = id
    @grade = grade
    @student_id = student_id
    @subject_id = subject_id
  end
end
