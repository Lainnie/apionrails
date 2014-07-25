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
end
