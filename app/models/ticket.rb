class Ticket < ActiveRecord::Base
  include Generator

  after_save :create_history

  has_many :histories  
  enum department: { dept1: 0,
                     dept2: 1,
                     dept3: 2 }
  enum status: { waiting_for_stuff_response: 0,
                 waiting_for_customer: 1,
                 on_hold: 2, canceled: 3,
                 completed: 4 }

  validates :name, :email, :subject, :body, :random_id,  presence: true
  validates :random_id, uniqueness: true
  validates :status, inclusion: { in: statuses.keys }, presence: true
  validates :department, inclusion: { in: departments.keys }, presence: true 

  def create_history
    histories.create(event: "#{current_status}")
  end
  def dept
    self.department.humanize
  end

  def current_status
    self.status.humanize
  end
end