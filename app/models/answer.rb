class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates :response, presence: true
  #validate :add_error
 
  #def add_error
  #  if response.blank?
  #    errors[:base] << "回答を入力してください"
  #  end
  #end

end
