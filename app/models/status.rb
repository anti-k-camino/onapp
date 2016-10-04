class Status < ActiveRecord::Base
  include StateAssign

  has_many :tickets

  validates :state, presence: true
  validates :state, uniqueness: true  

  def self.current_state(stat)
    "Statutus : #{Status.find(stat).state}"
  end
end
