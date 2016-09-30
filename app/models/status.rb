class Status < ActiveRecord::Base
  include StateAssign

  has_many :tickets

  validates :state, presence: true
  validates :state, uniqueness: true  
end
