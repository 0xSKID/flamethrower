require 'rails_helper'
RSpec.describe Message do

  describe 'self.build_from(raw_data)' do
    let(:account) do
      Account.create
    end

    let(:prospect) do
      Prospect.create(account: account)
    end

    let(:message) do
      Message.build_from(raw_data).tap do |message|
        message.person = prospect
        message.save
      end
    end

    let(:raw_data) do
      {
        '_id' => '1',
        'to' => '8',
        'from' => '6',
        'message' => 'Tell me something about yourself',
        'created_date' => '2018-02-07T00:37:44Z'
      }
    end

    it 'creates a raw data model' do
      expect(message.tinder_id).to eq(raw_data['_id'])
      expect(message.to_tinder_id).to eq(raw_data['to'])
      expect(message.from_tinder_id).to eq(raw_data['from'])
      expect(message.text).to eq(raw_data['message'])
      expect(message.tinder_timestamp).to eq(Time.parse(raw_data['created_date']))
    end
  end

  describe 'set_type' do
    let(:account) do
      Account.create(tinder_id: '4')
    end

    let(:person) do
      Person.create(account: account, tinder_id: '5')
    end

    let(:account_tinder_id) do
      account.tinder_id
    end

    let(:person_tinder_id) do
      person.tinder_id
    end

    context 'when message is from the person it belongs to' do
      let(:message) do
        Message.create(person: person, from_tinder_id: person_tinder_id, to_tinder_id: account_tinder_id)
      end

      it 'sets type to ReceivedMessage' do
        message.set_type
        expect(message.type).to eq('ReceivedMessage')
      end
    end

    context 'when message is from the account its person belongs to' do
      let(:message) do
        Message.create(person: person, from_tinder_id: account_tinder_id, to_tinder_id: person_tinder_id)
      end

      it 'sets type to SentMessage' do
        message.set_type
        expect(message.type).to eq('SentMessage')
      end
    end
  end
end
