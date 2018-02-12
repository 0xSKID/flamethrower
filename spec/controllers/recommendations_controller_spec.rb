require 'rails_helper'
RSpec.describe RecommendationsController do
  before do
    allow_any_instance_of(RecommendationsController).to receive(:authenticate)
  end

  describe 'GET /recommendations/:account_id' do
    let!(:account) do
      Account.create
    end

    context 'when account exists' do
      it 'kicks off recommendations worker' do
        expect(RecommendationsWorker).to receive(:perform_async).with(account.id)
        get :kickoff, params: { account_id: account.id }
      end
    end

    context 'when account does not exist' do
      it 'does not kickoff recommendations worker' do
        expect(RecommendationsWorker).not_to receive(:perform_async)
        get :kickoff, params: { account_id: account.id + 1 }
      end
    end
  end
end
