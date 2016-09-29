class Reply < ActiveRecord::Base
  belongs_to :ticket
  validates :ticket_id, :body, presence: true
  def self.track_ownership(v)
    "Ownership set to #{Stuff.find(v["stuff_id"][1]).name}" if v["stuff_id"].present?    
  end
  
end
