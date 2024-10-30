# frozen_string_literal: true

module Actions
  def show_students
    @klass = Klass.show_klasses(@items, @input)
    @items = Student.dict(@klass.id)
    @menu_items = Student::MENU_ITEMS
    @nesting += 1
  end

  def show_subjects
    @student = Student.dict(@klass.id).values[@input.to_i - 1]
    puts "Список предметов #{@student.full_name}"
    @items = Subject.dict(@klass.id)
    @menu_items = Subject::MENU_ITEMS
    @nesting += 1
  end

  def show_ratings
    @subject = Subject.dict(@klass.id).values[@input.to_i - 1]
    puts "Список оценок #{@student.full_name}. Предмет: #{@subject.name}"
    @items = Rating.dict(@subject.id, @student.id)
    @menu_items = Rating::MENU_ITEMS
    @nesting += 1
  end

  def add_class
    print 'Введите название класса: '
    name = gets&.strip
    Klass.add_class(name)
    @items = Klass.all
    puts 'Класс успешно добавлен!'
  end

  def add_student
    print 'Введите ФИО ученика: '
    full_name = gets&.strip
    Student.add_student(full_name, @klass.id)
    @items = Student.dict(@klass.id)
    @menu_items = Student::MENU_ITEMS
    puts 'Ученик успешно добавлен!'
  end

  def add_subject
    print 'Введите название предмета: '
    name = gets&.strip

    Subject.add(name, @klass.id)

    @items = Subject.dict(@klass.id)
    @menu_items = Subject::MENU_ITEMS

    puts 'Предмет успешно добавлен!'
  end

  def add_rating
    print 'Введите оценку: '
    grade = gets&.strip

    Rating.add(grade, @subject.id, @student.id)

    @items = Rating.dict(@subject.id, @student.id)
    @menu_items = Rating::MENU_ITEMS

    puts 'Оценка успешно записана!'
  end

  def edit_class
    print "Введите номер класса который хотите отредактировать от 1 до #{@items.size}: "
    index = gets.to_i
    print 'Введите новое название: '
    new_name = gets&.strip
    Klass.edit_class(new_name, index)
    @items = Klass.all
    puts 'Название класса успешно отредактировано!'
  end

  def edit_student
    print "Введите номер ученика который хотите отредактировать от 1 до #{@items.size}: "
    index = gets.to_i

    print 'Введите новое название: '
    new_name = gets&.strip

    item = Student.dict(@klass.id).values[index - 1]
    Student.edit(item, new_name)
    puts 'ФИО ученика успешно отредактировано!'

    @items = Student.dict(@klass.id)
    @menu_items = Student::MENU_ITEMS
  end

  def edit_subject
    print "Введите номер предмета который хотите отредактировать от 1 до #{@items.size}: "
    index = gets.to_i

    print 'Введите новое название предмета: '
    new_name = gets&.strip

    subject = Subject.dict(@klass.id).values[index - 1]
    Subject.edit(subject, new_name)
    puts 'Название предмета успешно отредактировано!'

    @items = Subject.dict(@klass.id)
    @menu_items = Subject::MENU_ITEMS
  end

  def edit_rating
    print "Введите номер оценки которою хотите отредактировать от 1 до #{@items.size}: "
    index = gets.to_i

    print 'Введите новою оценку: '
    new_grade = gets&.strip

    grade = Rating.dict(@subject.id, @student.id).values[index - 1]
    Rating.edit(grade, new_grade)
    puts 'Оценка успешно отредактирована!'

    @items = Rating.dict(@subject.id, @student.id)
    @menu_items = Rating::MENU_ITEMS
  end

  def delete_klass
    print "Введите номер класса который хотите удалить от 1 до #{@items.size}: "
    index = gets.to_i
    Klass.delete_class(index)
    @items = Klass.all
    puts 'Класс успешно удален!'
  end

  def delete_student
    print "Введите номер ученика которого хотите удалить от 1 до #{@items.size}: "
    index = gets.to_i

    item = Student.dict(@klass.id).values[index - 1]
    Student.delete(item)

    @items = Student.dict(@klass.id)
    @menu_items = Student::MENU_ITEMS

    puts 'Ученик успешно удален!'
  end

  def delete_subject
    print "Введите номер предмета который хотите удалить от 1 до #{@items.size}: "
    index = gets.to_i

    item = Subject.dict(@klass.id).values[index - 1]
    Subject.delete(item)

    @items = Subject.dict(@klass.id)
    @menu_items = Subject::MENU_ITEMS

    puts 'Предмет успешно удален!'
  end

  def delete_rating
    print "Введите номер оценки которую хотите удалить от 1 до #{@items.size}: "
    index = gets.to_i

    item = Rating.dict(@subject.id, @student.id).values[index - 1]
    Rating.delete(item)

    @items = Rating.dict(@subject.id, @student.id)
    @menu_items = Rating::MENU_ITEMS

    puts 'Оценка успешна удалена!'
  end

  def backward
    case @nesting
    when 1
      @items = Klass.all
      @menu_items = Klass::MENU_ITEMS
      @nesting -= 1
    when 2
      @items = Student.dict(@klass.id)
      @menu_items = Student::MENU_ITEMS
      @nesting -= 1
    when 3
      @items = Subject.dict(@klass.id)
      @menu_items = Subject::MENU_ITEMS
      @nesting -= 1
    else
      raise StandardError, 'Введено не валидное значение!'
    end
  end
end
