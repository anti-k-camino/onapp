class Reply < ActiveRecord::Base
  belongs_to :ticket
  validates :ticket_id, :body, presence: true
  after_create :set_status


  
  def self.track_ownership(v)
    "Ownership set to #{Stuff.find(v["stuff_id"][1]).name}" if v["stuff_id"].present?    
  end

  protected
  def set_status
    ticket.update(status: Status.waiting_for_customer) if ticket.status == Status.waiting_for_stuff_response
  end  
end
