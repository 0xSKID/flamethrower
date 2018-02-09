require 'rails_helper'
RSpec.describe Person do
  let!(:account) do
    create(:account, tinder_id: '1')
  end

  let!(:person) do
    create(:person, tinder_id: '2', account: account)
  end

  context 'message queries' do
    let!(:sent_message) do
      create(:message,
             from_tinder_id: account.tinder_id,
             to_tinder_id: person.tinder_id,
             person: person)
    end

    let!(:received_message) do
      create(:message,
             from_tinder_id: person.tinder_id,
             to_tinder_id: account.tinder_id,
             person: person)
    end

    describe 'received_messages' do
      it 'pulls messages where type is ReceivedMessage' do
        expect(person.received_messages.first.id).to eq(received_message.id)
      end
    end

    describe 'sent_messages' do
      it 'pulls messages where type is SentMessage' do
        expect(person.sent_messages.first.id).to eq(sent_message.id)
      end
    end
  end

  describe 'send_message' do
    let(:client) { instance_double(Tinder::Client) }
    it 'sends a message to tinder client with tinder_id and message text' do
      expect(Tinder::Client).to receive(:new).and_return(client)
      expect(client).to receive(:message).with(person.tinder_id, 'message')
      person.send_message('message')
    end
  end
end
