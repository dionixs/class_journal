# frozen_string_literal: true

module Statistics
  def average_score(subject_id, student_id)
    grades_count = { 5 => 0, 4 => 0, 3 => 0, 2 => 0 }

    Rating.dict(subject_id, student_id).to_a.my_each do |item|
      grades_count[item[1].grade] += 1
    end

    five = grades_count[5]
    four = grades_count[4]
    three = grades_count[3]
    two = grades_count[2]

    total = five + four + three + two
    total > 0 ? (5 * five + 4 * four + 3 * three + 2 * two) / total.to_f : 0
  end
end
