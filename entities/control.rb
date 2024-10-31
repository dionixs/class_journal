# frozen_string_literal: true

# TODO:
# применить Enumerator ?
class Control
  include Actions
  include ValidateInput

  attr_accessor :items, :menu_items, :nesting

  def initialize
    @items = Klass.all
    @menu_items = Klass::MENU_ITEMS
    @nesting = 0
    @input = nil
    @klass = nil
    @student = nil
    @subject = nil
  end

  def show_menu
    MenuItems.show_menu_items(@items, @menu_items, @student)
  end

  # пока не придумал как отрефакторить этот метод
  # кроме способа с использованием send
  #
  # есть идея сделать разные сущности
  # для каждого типа действий, но пока думаю над тем как лучше сделать
  def choice_action(input)
    @input = input
    if show_students?
      show_students
    elsif show_subjects?
      show_subjects
    elsif show_rating?
      show_ratings
    elsif add_class?
      add_class
    elsif add_student?
      add_student
    elsif add_subject?
      add_subject
    elsif add_rating?
      add_rating
    elsif edit_class?
      edit_class
    elsif edit_student?
      edit_student
    elsif edit_subject?
      edit_subject
    elsif edit_rating?
      edit_rating
    elsif delete_klass?
      delete_klass
    elsif delete_student?
      delete_student
    elsif delete_subject?
      delete_subject
    elsif delete_rating?
      delete_rating
    elsif backward?
      backward
    else
      raise StandardError, 'Введено не валидное значение!'
    end
  end
end
