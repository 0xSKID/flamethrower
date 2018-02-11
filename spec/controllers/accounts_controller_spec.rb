require 'rails_helper'
RSpec.describe AccountsController do

  let!(:account) do
    Account.create
  end

  describe 'GET /accounts' do
    it 'gets all current accounts' do
      get :index
      expect(response.code).to eq('200')
      expect(JSON.parse(response.body).first['id']).to eq(account.id)
    end
  end
end
