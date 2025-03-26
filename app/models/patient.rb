class Patient < ApplicationRecord
  self.primary_key = :id

  belongs_to :user
  has_many :diagnostic_screener_instances

  validates :first_name, :last_name, :email, presence: true
end
