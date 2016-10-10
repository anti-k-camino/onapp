require 'rails_helper'

RSpec.describe Search do
  describe '.search_selection' do
    %w(subject_id random_id).each do |selection|
      it "call #{selection}" do
        #expect(Ticket).to receive(("by_" + selection).to_sym)??????
        Search.search_selection('query', "#{selection}")
      end
    end
  end

  it 'call selection All' do
    expect(Ticket).to receive(:search).with('query')
    Search.search_selection('query', 'All')
  end

  it 'call invalid selection' do
    expect(ThinkingSphinx).to_not receive(:search).with('query')
    Search.search_selection('query', 'invalid')
  end
end
