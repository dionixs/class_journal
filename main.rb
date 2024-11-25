# frozen_string_literal: true

require_relative './lib/my_methods'
require_relative './entities/klass'
require_relative './entities/student'
require_relative './modules/statistics'
require_relative './entities/subject'
require_relative './entities/rating'
require_relative './modules/menu_items'
require_relative './modules/input_handler'
require_relative './modules/actions'
require_relative './modules/validate_input'
require_relative './entities/control'

# TODO:
# - придумать как отрефакторить метод choice_action в классе Control
# - придумать как отрефакторить метод show_menu_items в модуле MenuItems

control = Control.new

puts 'Добро пожаловать в программу классный журнал!'

begin
  loop do
    control.show_menu
    input = InputHandler.user_input

    break if input == 'exit'

    control.choice_action(input)
  rescue StandardError => e
    puts "Возникла ошибка: #{e.message}"
  end
rescue Interrupt
  puts
end
