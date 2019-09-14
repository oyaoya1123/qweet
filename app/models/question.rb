class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, dependent: :destroy
  has_many :question_categorys, dependent: :destroy
  has_many :categorys, through: :question_categorys

  validates :content, presence: true
  validates :title, presence: true

  #validate :add_error
 
  #def add_error

  #  if title.blank?
  #    errors[:base] << "タイトルを入力してください"
  #  end

  #  if content.blank?
  #    errors[:base] << "質問を入力してください"
  #  end

  #end

end
