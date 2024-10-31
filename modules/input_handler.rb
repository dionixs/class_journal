# frozen_string_literal: true

module InputHandler
  def self.user_input
    print '> '
    gets&.strip
  end
end
