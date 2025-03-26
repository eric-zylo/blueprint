class Question < ApplicationRecord
  belongs_to :questionable, polymorphic: true
  has_many :answers
  has_one :domain_mapping

  validates :title, presence: true
end
