require 'rails_helper'
RSpec.describe Prospect do
  let(:raw_data) do
    OpenStruct.new(name: 'Jessica',
                   photos: [
                     OpenStruct.new(url: 'url'),
                     OpenStruct.new(url: 'url'),
                     OpenStruct.new(url: 'url')
                   ],
                   _id: '537')
  end

  describe 'self.build_from(raw_data)' do
    it 'creates a raw data model' do
      prospect = Prospect.build_from(raw_data)
      byebug
      expect(prospect.raw_data.name).to eq(raw_data.name)
      expect(prospect.raw_data.photos).to eq(raw_data.photos)
      expect(prospect.raw_data.tinder_id).to eq(raw_data.tinder_id)
    end

    it 'combines photo urls into one string' do
      Prospect.build_from(raw_data)
      expect(Prospect.last.photos).to eq('url url url')
    end

    it 'it maps _id to tinder_id' do
      Prospect.build_from(raw_data)
      expect(Prospect.last.photos).to eq('537')
    end
  end
end
