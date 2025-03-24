class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validate :password_complexity

  private

  def password_complexity
    return if password.blank?

    rules = {
      "must include at least one digit" => /\d/,
      "must include at least one lowercase letter" => /[a-z]/,
      "must include at least one uppercase letter" => /[A-Z]/,
      "must include at least one special character" => /[^A-Za-z0-9]/
    }

    rules.each do |message, regex|
      errors.add(:password, message) unless password.match?(regex)
    end
  end
end
