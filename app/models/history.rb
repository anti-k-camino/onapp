class History < ActiveRecord::Base
  belongs_to :ticket
  validates :event, presence: true
end
