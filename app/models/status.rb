class Status < ActiveRecord::Base
  validates :state, presence: true
  validates :state, uniqueness: true

  has_many :tickets

  def self.unassigned
    #where(state: 'waiting for stuff response').first.tickets
    joins(:tickets).where(state: 'waiting for stuff response')
  end

  def self.opened    
    joins(:tickets).where.not("state = 'canceled' OR state = 'closed'")
  end

  def self.onhold
    joins(:tickets).where(state: 'on hold')
  end

  def self.closed
   joins(:tickets).where("state = 'canceled' OR state = 'closed'")
  end
end
