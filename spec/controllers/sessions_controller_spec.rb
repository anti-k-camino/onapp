require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST#create' do
    context 'existing stuff without token' do
      let!(:stuff){ create :stuff }
      it 'should assign stuff to @stuff' do
        post :create, name: stuff.name, password: stuff.password
        expect(assigns :stuff).to eq stuff
      end

      it 'should create a session with stuff id' do 
        post :create, name: stuff.name, password: stuff.password
        expect(session[:stuff_id]).to eq stuff.id
      end      

      it 'should redirect to root path' do
        post :create, name: stuff.name, password: stuff.password
        expect(response).to redirect_to opened_dashboard_path
      end
    end
    
    context 'non existing user' do      

      it 'should not create a session with stuff id' do 
        post :create, name: 'nname', password: '654321'
        expect(session[:stuff_id].present?).to be_falsy
      end

      it 'should redirect to root path' do        
        post :create, name: 'nname', password: '654321'
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET#destroy' do
    context 'Authenticated stuff' do
      let!(:stuff){ create :stuff }
      sign_in_stuff

      before { get :destroy, id: stuff.id }      
      
      it "should should delete session's stuff_id" do        
        expect(session[:stuff_id]).to eq nil
      end

      it "should redirect to root path" do
        expect(response).to redirect_to login_path
      end
    end

    context 'Non-authenticatd stuff' do
      it "should redirect to signup path" do
        get :destroy
        expect(response).to redirect_to login_path
      end
    end    
  end
end
