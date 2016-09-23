RSpec.shared_examples_for 'Non Authorizable' do
  
  context 'non-authorized' do
    it 'should render template unassigned' do
      request[1]
      expect(response).to redirect_to login_path
    end
  end
  
end