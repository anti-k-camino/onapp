class Ticket < ActiveRecord::Base
  include Generator
  has_paper_trail only:[:stuff_id, :status], on:[:update] 
  has_many :replies
  accepts_nested_attributes_for :replies, reject_if: lambda{ |attributes| attributes['body'].blank? }
  
  #around_update :create_history
  #has_many :histories 
  
  belongs_to :stuff
   
  enum department: { dept1: 0,
                     dept2: 1,
                     dept3: 2 }
  enum status: { waiting_for_stuff_response: 0,
                 waiting_for_customer: 1,
                 on_hold: 2, 
                 canceled: 3,
                 completed: 4 }

  validates :name, :email, :subject, :body, :random_id,  presence: true
  validates :random_id, uniqueness: true
  validates :status, inclusion: { in: statuses.keys }, presence: true
  validates :department, inclusion: { in: departments.keys }, presence: true 
  
  def dept
    self.department.humanize
  end

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
