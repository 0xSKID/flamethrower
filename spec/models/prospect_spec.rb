require 'rails_helper'
RSpec.describe Prospect do

  let(:account) do
    Account.create
  end

  let(:prospect) do
    Prospect.build_from(raw_data).tap do |prospect|
      prospect.account = account
      prospect.save
    end
  end

  let(:raw_data) do
    {
      'name' => 'Jessica',
      'photos' => [
        { 'url' => 'url'},
        { 'url' => 'url'},
        { 'url' => 'url'}
      ],
      '_id' => '537'
    }
  end

  describe 'self.build_from(raw_data)' do
    it 'creates a raw data model' do
      expect(prospect.raw_data.data['name']).to eq(raw_data['name'])
      expect(prospect.raw_data.data['photos']).to eq(raw_data['photos'])
      expect(prospect.raw_data.data['tinder_id']).to eq(raw_data['tinder_id'])
    end

    it 'combines photo urls into one string' do
      expect(prospect.photos).to eq('url url url')
    end

    it 'it maps _id to tinder_id' do
      expect(prospect.tinder_id).to eq('537')
    end
  end
end
