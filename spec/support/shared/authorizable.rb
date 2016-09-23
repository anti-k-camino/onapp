RSpec.shared_examples_for 'Authorizable' do
  
  context 'authorized' do     
    sign_in_stuff
    before do
      request[1]
    end
    it 'should populate an array of propper tickets' do        
      expect( assigns :tickets ).to eq tickets
    end

    it 'should render propper template ' do         
      expect(response).to render_template request[0]
    end
  end
  
end