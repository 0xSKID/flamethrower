require 'rails_helper'
RSpec.describe ProspectsController do
  describe 'GET /accounts/:account_id/prospects' do
    let!(:account) do
      Account.create
    end

    let!(:prospect) do
      Prospect.create(account: account)
    end

    it 'loads prospects' do
      get :index, params: { account_id: account.id }
    end
  end
end
