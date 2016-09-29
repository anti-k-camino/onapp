class Department < ActiveRecord::Base
  has_many :tickets
  
  validates :title, presence: true
  validates :title, uniqueness: true
end
