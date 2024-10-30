# frozen_string_literal: true

require_relative './lib/my_methods'
require_relative './entities/klass'
require_relative './entities/student'
require_relative './entities/subject'
require_relative './entities/rating'
require_relative './modules/menu_items'
require_relative './modules/input_handler'
require_relative './modules/validate_input'
require_relative './entities/control'

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

# TODO:
# - Cделать обработку ошибок
# - Сделать рефакторинг этого безобразия и всего проекта в целом
# TODO: Сделать возможность вернуться назад в меню
#   # nesting -= 0 if user_input == 'prev' && nesting != 0
#
