class Reply < ActiveRecord::Base
  belongs_to :ticket
  validates :ticket_id, :body, presence: true
end
