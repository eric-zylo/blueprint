class Question < ApplicationRecord
  has_many :answers
  has_one :domain_mapping

  validates :title, presence: true
end
