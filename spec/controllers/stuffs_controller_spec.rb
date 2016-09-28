require 'rails_helper'

RSpec.describe StuffsController, type: :controller do
  describe 'GET#new' do
    it 'should render view new' do
      get :new 
      expect(response).to render_template :new
    end
  end

  describe 'POST#create' do
    context 'Valid attributes' do
      it 'should create a new user' do
        expect{ post :create, stuff: attributes_for(:stuff) }.to change(Stuff, :count).by(1)
      end

      it 'should create a new stuff session' do
        post :create, stuff: attributes_for(:stuff)
        expect(session[:stuff_id].present?).to be_truthy
      end

      it 'should redirect to root path' do
        post :create, stuff: attributes_for(:stuff)
        expect(response).to redirect_to opened_dashboard_path
      end
    end

    context 'Inalid attributes' do
      it 'should not create a new user' do
        expect{ post :create, stuff: {password: '123123'} }.to_not change(Stuff, :count)
      end

      it 'should create a new stuff session' do
        post :create, stuff: {password: '123123'}
        expect(session[:stuff_id].present?).to be_falsy
      end

      it 'should redirect to root path' do
        post :create, stuff: {password: '123123'}
        expect(response).to redirect_to signup_path
      end
    end
  end
end
