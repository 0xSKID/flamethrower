require 'rails_helper'
RSpec.describe ProspectsController do
  describe 'GET /accounts/:account_id/prospects' do
    let(:account) do
      Account.create
    end

    it 'loads prospects' do
      expect(Prospect).to receive(:all)
      get :index, params: { account_id: account.id }
    end
  end
end
