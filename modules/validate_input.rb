# frozen_string_literal: true

module ValidateInput
  private

  def add?
    @input.to_i == @items.size + 1
  end

  def add_class?
    add? && @nesting == 0
  end

  def add_student?
    add? && @nesting == 1
  end

  def add_subject?
    add? && @nesting == 2
  end

  def add_rating?
    add? && @nesting == 3
  end

  def edit?
    @items.size + 2 == @input.to_i
  end

  def edit_class?
    edit? && @nesting == 0
  end

  def edit_student?
    edit? && @nesting == 1
  end

  def edit_subject?
    edit? && @nesting == 2
  end

  def edit_rating?
    edit? && @nesting == 3
  end

  def delete?
    @items.size + 3 == @input.to_i
  end

  def delete_klass?
    delete? && @nesting == 0
  end

  def delete_student?
    delete? && @nesting == 1
  end

  def delete_subject?
    delete? && @nesting == 2
  end

  def delete_rating?
    delete? && @nesting == 3
  end

  def show_students?
    valid_input? && @nesting == 0
  end

  def show_subjects?
    valid_input? && @nesting == 1
  end

  def show_rating?
    valid_input? && @nesting == 2
  end

  def valid_input?
    @input.to_i > 0 && @input.to_i <= @items.length
  end
end
