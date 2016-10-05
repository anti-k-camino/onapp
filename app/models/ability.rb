class Ability
  include CanCan::Ability

  attr_reader :stuff
  
  def initialize(stuff) 
    @stuff = stuff  
    if stuff
      stuff.admin? ? admin_abilities : stuff_abilities     
    else
      guest_abilities
    end    
  end

  def guest_abilities
    can :create, Ticket
    can :show, Ticket
    can :update, Ticket
  end

  def stuff_abilities
    guest_abilities
    can :stuff_update, Ticket do |ticket| 
      stuff.owner_of?(ticket) || (ticket.stuff_id == nil)
    end
    can :search, Search
  end
end
