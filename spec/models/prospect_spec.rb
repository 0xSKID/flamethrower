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

  describe 'like!' do
    let(:client) { instance_double(Tinder::Client) }
    it 'sends a message to tinderclient to like with prospect id, changes prospect type to liked and saves' do
      expect(Tinder::Client).to receive(:new).and_return(client)
      expect(client).to receive(:like).with(prospect.tinder_id)
      prospect.like!
      expect(Person.find(prospect.id).class).to be(Liked)
    end
  end

  describe 'pass!' do
    let(:client) { instance_double(Tinder::Client) }
    it 'sends a message to tinder client to pass with prospect id, changes prospect type to passed and saves' do
      expect(Tinder::Client).to receive(:new).and_return(client)
      expect(client).to receive(:pass).with(prospect.tinder_id)
      prospect.pass!
      expect(Person.find(prospect.id).class).to be(Passed)
    end
  end
end
