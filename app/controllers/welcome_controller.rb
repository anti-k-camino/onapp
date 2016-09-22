class WelcomeController < ApplicationController
  def ticket
    @ticket = Ticket.new
  end
end
