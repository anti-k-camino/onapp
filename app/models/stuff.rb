class Stuff < ActiveRecord::Base
  has_secure_password
  has_many :tickets
  validates :name, presence: true
  validates :name, uniqueness: true
end
