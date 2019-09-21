require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(title content name)
  csv << csv_column_names
  @questions.each do |question|
    csv_column_values = [
      question.title,
      question.content,
      question.user.name
    ]
    csv << csv_column_values
  end
end