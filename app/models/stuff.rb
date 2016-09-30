class Stuff < ActiveRecord::Base
  has_secure_password
  has_many :tickets
  validates :name, presence: true
  validates :name, uniqueness: true

  def owner_of?(ticket)
    id == ticket.stuff_id
  end
end
