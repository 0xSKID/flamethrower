require 'rails_helper'
RSpec.describe ResponsivesController do
  before do
    allow_any_instance_of(ResponsivesController).to receive(:authenticate)
  end

  describe 'GET /accounts/:account_id/responsives' do
    let!(:account) do
      Account.create
    end

    let!(:responsive) do
      Responsive.create(account: account)
    end

    it 'loads and renders responsives' do
      get :index, params: { account_id: account.id }
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body).first['id']).to eq(responsive.id)
    end
  end
end
