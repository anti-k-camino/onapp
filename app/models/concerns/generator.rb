require 'active_support/concern'
module Generator
  extend ActiveSupport::Concern  

  included do
    public_class_method :generate_id
    private_class_method :gen_str
    private_class_method :gen_hex    
  end 

  module ClassMethods
    def generate_id
      "#{gen_str}-#{gen_hex}-#{gen_str}-#{gen_hex}-#{gen_str}"
    end
    
    def gen_str
      (('a'..'z').to_a + ('A'..'Z').to_a).shuffle[0,3].join  
    end

    def gen_hex    
      SecureRandom.hex(1)
    end
  end
end