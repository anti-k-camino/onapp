class Ticket < ActiveRecord::Base
  include Generator
  has_paper_trail only:[:stuff_id, :status], on:[:update] 
  has_many :replies
  belongs_to :stuff
  belongs_to :department
  belongs_to :status

  accepts_nested_attributes_for :replies, reject_if: lambda{ |attributes| attributes['body'].blank? }     

  validates :name, :email, :subject, :body, :status_id, :random_id, :department_id, presence: true
  validates :random_id, uniqueness: true 
 

  def self.unassigned
    #where(status: 'waiting for stuff response')
    #joins("INNER JOIN statuses ON status.state = 'waiting for stuff response'")
    joins(:status).where("state = 'waiting for stuff response'")
  end

  def self.opened
    joins(:status).where.not("state = 'canceled' OR state = 'closed'")
  end

  def self.onhold
    joins(:status).where("state = 'on hold'")
  end

  def self.closed
    joins(:status).where("state = 'canceled' OR state = 'closed'")
  end
  
  def current_status
    self.status.humanize
  end
end
