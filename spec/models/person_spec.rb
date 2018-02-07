require 'rails_helper'
RSpec.describe Person do

  let!(:account) do
    Account.create
  end

  describe 'set_type' do
    context 'when a person is in a state that it is immutable' do
      let!(:dated) do
        Dated.create(account: account, messages: [Message.create])
      end
      let!(:lost) do
        Lost.create(account: account, messages: [Message.create] )
      end

      it 'does not change its type when type is dated' do
        dated.set_type
        expect(dated.type).to eq('Dated')
      end

      it 'does not change its type when type is lost' do
        lost.set_type
        expect(lost.type).to eq('Lost')
      end
    end

    context 'when a person doesn\'t have any messages' do
      let!(:person) do
        Person.create(account: account)
      end

      it 'changes its type to Prospect' do
        person.set_type
        expect(person.type).to eq('Prospect')
      end
    end

    context 'when a person has one Message' do
      let!(:person) do
        Person.create(account: account, messages: [Message.create])
      end

      it 'changes its type to Match' do
        person.set_type
        expect(person.type).to eq('Match')
      end
    end

    context 'when a person has more than one received message and one sent message' do
      let!(:person) do
        Person.create(account: account, messages: [ReceivedMessage.create, SentMessage.create])
      end

      it 'changes its type to Replied' do
        person.set_type
        expect(person.type).to eq('Replied')
      end
    end

    context 'when a person has more than one sent message' do
      let!(:person) do
        Person.create(account: account, messages: [ReceivedMessage.create, SentMessage.create, SentMessage.create])
      end

      it 'changes its type to Responsive' do
        person.set_type
        expect(person.type).to eq('Responsive')
      end
    end
  end
end
