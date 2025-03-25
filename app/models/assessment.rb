class Assessment < ApplicationRecord
  self.primary_key = :id

  belongs_to :patient
  has_many :answers

  before_create :generate_token

  validates :token, uniqueness: true

  private

  def generate_token
    self.token = SecureRandom.hex(16)
  end
end
