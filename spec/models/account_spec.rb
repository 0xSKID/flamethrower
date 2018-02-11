require 'rails_helper'
RSpec.describe Account do

  let(:raw_data) do
    {
      'user' => {
        '_id' => 'dope id'
      },
      'tinder_api_token' => 'dope token'
    }
  end

  let(:account) do
    Account.build_from(raw_data).tap do |account|
      account.save
    end
  end

  describe 'self.build_from(raw_data)' do
    it 'creates a raw_data model' do
      expect(account.raw_data.data['token']).to eq(raw_data['token'])
    end

    it 'maps tinder_id and tinder_api_token' do
      expect(account.tinder_id).to eq(raw_data['user']['_id'])
      expect(account.tinder_api_token).to eq(raw_data['token'])
    end
  end
end
