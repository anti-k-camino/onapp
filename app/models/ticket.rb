class Ticket < ActiveRecord::Base
  include Generator
  has_paper_trail only:[:stuff_id, :status_id], on:[:update] 
  has_many :replies
  belongs_to :stuff
  belongs_to :department
  belongs_to :status

  before_validation(on: :create) do
    self.random_id = Ticket.generate_id 
    self.status = Status.waiting_for_stuff_response if self.status == nil
  end 

  accepts_nested_attributes_for :replies, reject_if: lambda{ |attributes| attributes['body'].blank? }     

  validates :name, :email, :subject, :body, :status_id, :department_id, presence: true
  validates :random_id, uniqueness: true 

  def guest_update_avilable?
    status.state == 'waiting for customer'
  end 

  def self.unassigned    
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
