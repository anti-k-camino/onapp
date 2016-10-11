class Search < ActiveRecord::Base
  SELECTION = %w(subject random_id All)

  def self.search_selection(query, selection)
    return [] unless SELECTION.include? selection
    if selection == 'All'
      Ticket.search ThinkingSphinx::Query.escape(query)
    else      
      Ticket.attr_search(query, selection)
    end
  end  
end
