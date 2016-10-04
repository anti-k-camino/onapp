require 'rails_helper'

RSpec.describe SearchController, type: :controller do
 
  describe 'GET #search' do
    sign_in_stuff
    let(:do_request){ get :search, { selection: 'subject', query: 'test' } }

    it_behaves_like 'Renderable templates', :search

    context 'search' do
      it 'should receive search' do
        expect(Search).to receive(:search_selection)
        do_request
      end
    end
  end
end
