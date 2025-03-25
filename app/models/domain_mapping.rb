class DomainMapping < ApplicationRecord
  belongs_to :question

  enum :domain, {
    depression: 0,
    mania: 1,
    anxiety: 2,
    substance_use: 3
  }

  validates :domain, presence: true
end
