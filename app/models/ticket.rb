class Ticket < ActiveRecord::Base
  include Generator
  include ThinkingSphinx::Scopes
  has_paper_trail only:[:stuff_id, :status_id], on:[:update] 
  has_many :replies
  belongs_to :stuff
  belongs_to :department
  belongs_to :status

  

  sphinx_scope(:by_subject) { |name| {:conditions => {:subject => name}} }
  sphinx_scope(:by_random_id) { |name| {:conditions => {:random_id => name}} } 

  before_validation(on: :create) do
    self.random_id = Ticket.generate_id 
    self.status = Status.waiting_for_stuff_response if self.status.nil?
  end 

 

  accepts_nested_attributes_for :replies, reject_if: lambda{ |attributes| attributes['body'].blank? }     

  validates :name, :email, :subject, :body, :status_id, :department_id, presence: true
  validates :random_id, uniqueness: true 

  def guest_update_avilable?
    status.state == 'waiting for customer'
  end  

  def self.unassigned    
    where("stuff_id IS ?", nil)
  end

  def self.opened
    joins(:status).where.not("state = 'canceled' OR state = 'closed'")
  end

  def self.onhold
    joins(:status).where("state = 'on hold'")
  end

  def self.closed
    joins(:status).where("state = 'canceled' OR state = 'closed'")
  end

  def owner
    stuff_id ? stuff.name : "Not owned"
  end

  def self.attr_search(query, selection)
    self.send(("by_" + selection).to_sym, ThinkingSphinx::Query.escape(query)).send(:search)
  end 
end
