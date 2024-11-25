# frozen_string_literal: true

module MenuItems
  # хотелось бы упростить этот метод
  # но пока не придумал как
  def self.show_menu_items(items, menu_items, student = nil)
    items = items.values if items.is_a? Hash
    items += menu_items

    if items.first.instance_of?(Rating)
      puts "Выберите вариант от #{items.size - 3} до #{items.size}:"
    else
      puts "Выберите вариант от 1 до #{items.size}:"
    end

    items.my_each_with_index do |item, index|
      if item.instance_of?(Klass)
        puts "\t #{index + 1}. #{item&.name}"
      elsif item.instance_of?(Student)
        puts "\t #{index + 1}. #{item.full_name}"
      elsif item.instance_of?(Subject)
        average_score = Subject.average_score(item.id, student.id)
        puts "\t #{index + 1}. #{item.name} #{average_score}"
      elsif item.instance_of?(Rating)
        puts "\t #{index + 1}. #{item.grade}"
      else
        puts "\t #{index + 1}. #{item}"
      end
    end
  end
end
