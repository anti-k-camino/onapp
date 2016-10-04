class Search < ActiveRecord::Base
  SELECTION = %w(subject random_id All)

  def self.search_selection(query, selection)
    return [] unless SELECTION.include? selection
    if selection == 'All'
      Ticket.search ThinkingSphinx::Query.escape(query)
    else      
      Ticket.send(("by_" + selection).to_sym, ThinkingSphinx::Query.escape(query)).send(:search)
    end
  end
end
