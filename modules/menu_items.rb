# frozen_string_literal: true

module MenuItems
  # хотелось бы упростить этот метод
  # но пока не придумал как
  def self.show_menu_items(items, menu_items)
    items = items.values if items.is_a? Hash
    items += menu_items
    puts "Выберите вариант от 1 до #{items.size}:"
    items.my_each_with_index do |item, index|
      if item.instance_of?(Klass)
        puts "\t #{index + 1}. #{item&.name}"
      elsif item.instance_of?(Student)
        puts "\t #{index + 1}. #{item.full_name}"
      elsif item.instance_of?(Subject)
        puts "\t #{index + 1}. #{item.name}"
      elsif item.instance_of?(Rating)
        puts "\t #{index + 1}. #{item.grade}"
      else
        puts "\t #{index + 1}. #{item}"
      end
    end
  end
end
