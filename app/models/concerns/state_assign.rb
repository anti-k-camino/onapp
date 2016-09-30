require 'active_support/concern'
module StateAssign
  extend ActiveSupport::Concern  

  included do
    public_class_method :waiting_for_stuff_response
    public_class_method :waiting_for_customer
    public_class_method :on_hold
    public_class_method :canceled
    public_class_method :closed
        
  end 

  module ClassMethods
    def waiting_for_stuff_response
    find_by_state('waiting for stuff response')
    end

    def waiting_for_customer
      find_by_state('waiting for customer')
    end

    def on_hold
      find_by_state('on hold')
    end

    def canceled
      find_by_state('canceled')
    end

    def closed
      find_by_state('closed')
    end
  end
end