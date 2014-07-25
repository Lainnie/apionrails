require 'rails_helper'

RSpec.describe Api::V1::UsersController, :type => :controller do

  before(:each) do
    request.headers['Accept'] = 'application/vnd.marketplace.v1'
  end

  describe 'Get #show' do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id, format: :json
    end

    it 'return user' do
      user_response = json response.body
      expect(user_response[:email]).to eq(@user.email)
    end

    it { should respond_with(200) }
  end

  describe 'Post #create' do
    context 'When is successfully created' do
      before(:each) do
        post :create, { user: valid_attributes }, format: :json
        @user_response = json(response.body)
      end

      let(:valid_attributes) { FactoryGirl.attributes_for(:user) }

      it 'render json representation of user just created' do
        expect(@user_response[:email]).to eq(valid_attributes[:email])
      end

      it { should respond_with(201) }
    end

    context 'When creation fail' do
      before(:each) do
        post :create, { user: invalid_attributes }, format: :json
        @user_response = json(response.body)
      end

      let(:invalid_attributes) { FactoryGirl.attributes_for(:user_invalid) }

      it 'renders a errors json' do
        expect(@user_response).to have_key(:errors)
      end

      it 'renders a validation error message' do
        expect(@user_response[:errors][:email]).to include('can\'t be blank')
      end

      it { should respond_with(422) }
    end
  end
end
