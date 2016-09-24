class Ticket < ActiveRecord::Base
  include Generator
  
  around_update :create_history

  has_many :histories 
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
=begin
  def create_history
    histories.create(event: "#{current_status}")
  end
=end
  def create_history    
    @event_status = "Status to #{self.status}.\n" if status_changed?    
    @event_owner = "Now it is provided by #{self.stuff.name}\n" if stuff_id_changed?
    yield    
    histories.create(event: "Changed! #{@event_status} #{@event_owner} On #{self.updated_at.utc}") if @event_status || @event_owner
  end

  def status_owner_changed?
    status_changed? || stuff_id_changed?
  end
  
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
