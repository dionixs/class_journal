# frozen_string_literal: true

class Control
  include Actions
  include ValidateInput

  attr_accessor :items, :menu_items, :nesting

  ACTIONS = {
    show_students?: :show_students,
    show_subjects?: :show_subjects,
    show_rating?: :show_ratings,
    add_class?: :add_class,
    add_student?: :add_student,
    add_subject?: :add_subject,
    add_rating?: :add_rating,
    edit_class?: :edit_class,
    edit_student?: :edit_student,
    edit_subject?: :edit_subject,
    edit_rating?: :edit_rating,
    delete_klass?: :delete_klass,
    delete_student?: :delete_student,
    delete_subject?: :delete_subject,
    delete_rating?: :delete_rating,
    backward?: :backward
  }.freeze

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
  # есть идея сделать разные сущности
  # для каждого типа действий, но пока думаю над тем как лучше сделать
  #
  # возникла идея отрефакторить применяя вот такой способ:
  # https://stackoverflow.com/questions/13948910/ruby-methods-as-array-elements-how-do-they-work
  def choice_action(input)
    @input = input
    action = ACTIONS.find { |condition, _| send(condition) }

    raise StandardError, 'Введено не валидное значение!' unless action

    send(action.last)
  end
end
