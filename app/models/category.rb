class Category < ApplicationRecord
  has_many :question_categorys
  has_many :questions, through: :question_categorys
end
