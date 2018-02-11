require 'rails_helper'
RSpec.describe SwipeController do
  let!(:account) do
    Account.create
  end

  let!(:prospect) do
    Prospect.create(account: account)
  end

  before do
    allow_any_instance_of(Prospect).to receive(:like!).and_return(true)
    allow_any_instance_of(Prospect).to receive(:pass!).and_return(true)
  end

  describe 'GET /swipe/like' do
    it 'loads and renders prospects' do
      get :like, params: { id: prospect.id, account_id: account.id }
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['id']).to eq(prospect.id)
    end
  end

  describe 'GET /swipe/pass' do
    it 'loads and renders prospects' do
      get :pass, params: { id: prospect.id, account_id: account.id }
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body)['id']).to eq(prospect.id)
    end
  end
end
