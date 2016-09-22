class Ticket < ActiveRecord::Base
  include Generator
  validates :name, :email, :subject, :body, :department, :random_id,  presence: true
  validates :random_id, uniqueness: true
  enum department: { dept1: 0,
                     dept2: 1,
                     dept3: 2 }
  enum status: { witing_for_stuff_response: 0,
                   waiting_for_customer: 1,
                   on_hold: 2, canceled: 3,
                   completed: 4 }

  validates :status, inclusion: { in: statuses.keys }, presence: true
 
 
  def dept
    self.department.humanize
  end

  def current_status
    self.status.humanize
  end

end
