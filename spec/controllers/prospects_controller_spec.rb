require 'rails_helper'
RSpec.describe ProspectsController do
  describe 'GET /accounts/:account_id/prospects' do
    let!(:account) do
      Account.create
    end

    let!(:prospect) do
      Prospect.create(account: account)
    end

    it 'loads and renders prospects' do
      get :index, params: { account_id: account.id }
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body).first['id']).to eq(prospect.id)
    end
  end
end
