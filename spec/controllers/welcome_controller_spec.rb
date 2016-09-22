require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do

  describe 'GET# ticket' do
    it 'should render template ticket' do
      get :ticket
      expect(response).to render_template :ticket
    end
  end
end
