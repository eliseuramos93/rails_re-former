class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  validates :username, length: { in: 3..20 }, presence: true, uniqueness: true, 
    format: { with: /\w+/, message: 'only allows letters, numbers and underscores' }
  validates :password, length: { in: 8..20 }, presence: true, 
    format: { with: /(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}/,
      message: 'must have at least one letter, one number and one special character' }
  validates :email, presence: true, email: true
end
