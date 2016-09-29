class Ticket < ActiveRecord::Base
  include Generator
  has_paper_trail only:[:stuff_id, :status], on:[:update] 
  has_many :replies
  accepts_nested_attributes_for :replies, reject_if: lambda{ |attributes| attributes['body'].blank? }    
  
  belongs_to :stuff
  belongs_to :department
   
  
  enum status: { waiting_for_stuff_response: 0,
                 waiting_for_customer: 1,
                 on_hold: 2, 
                 canceled: 3,
                 completed: 4 }

  validates :name, :email, :subject, :body, :random_id, :department_id, presence: true
  validates :random_id, uniqueness: true
  validates :status, inclusion: { in: statuses.keys }, presence: true
  
  
 

  def self.unassigned
    where(status: 'waiting for stuff response')
  end

  def self.opened
    where.not("status = 3 OR status = 4")
  end

  def self.onhold
    where(status: 2)
  end

  def self.closed
    where("status = 3 OR status = 4")
  end
  
  def current_status
    self.status.humanize
  end
end
