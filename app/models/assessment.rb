class Assessment < ApplicationRecord
  self.primary_key = :id

  belongs_to :patient
  belongs_to :user

  has_many :answers

  validates :patient_id, :user_id, presence: true
end
