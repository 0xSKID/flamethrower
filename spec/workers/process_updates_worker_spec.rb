require 'rails_helper'
RSpec.describe 'ProcessUpdatesWorker' do

  let!(:account) do
    Account.create(tinder_id: '1')
  end

   let!(:prospect) do
     Prospect.create(account: account, tinder_id: '2', tinder_match_id: '3')
   end

  let(:raw_data) do
    {
      'last_activity_date' => Time.now.utc.iso8601,
      'matches' => []
    }
  end

  let!(:update) do
    update = Update.build_from(raw_data).tap do |update|
      update.account = account
      update.save
    end
  end

  describe 'perform' do
    context 'when there is no data to process' do
      it 'runs without any error' do
        expect(UpdatePersonTypeWorker).not_to receive(:perform_async)
        ProcessUpdatesWorker.new.perform(update.id)
      end
    end

    context 'when person is indentifiable by tinder_id' do
      let(:raw_data) do
        {
          'last_activity_date' => Time.now.utc.iso8601,
          'matches' => [
            {
              '_id' => '3',
              'messages' => [
                {
                  '_id' => '098',
                  'to' => prospect.tinder_id,
                  'from' => account.tinder_id,
                  'message' => 'ohai',
                  'created_date' => Time.now.utc.iso8601
                }
              ],
              'person' => {
                '_id' => prospect.tinder_id
              }
            }
          ]
        }
      end

      it 'pulls person by tinder_id and execute successfully' do
        expect(UpdatePersonTypeWorker).to receive(:perform_async).with(prospect.id)
        ProcessUpdatesWorker.new.perform(update.id)
      end
    end

    context 'when person is not identifieable by tinder_id' do
      let(:raw_data) do
        {
          'last_activity_date' => Time.now.utc.iso8601,
          'matches' => [
            {
              '_id' => '3',
              'messages' => [
                {
                  '_id' => '098',
                  'to' => prospect.tinder_id,
                  'from' => account.tinder_id,
                  'message' => 'ohai',
                  'created_date' => Time.now.utc.iso8601
                }
              ],
            }
          ]
        }
      end
      it 'pulls person by match_id and execute successfully' do
        expect(UpdatePersonTypeWorker).to receive(:perform_async).with(prospect.id)
        ProcessUpdatesWorker.new.perform(update.id)
      end
    end

    context 'when message already exists' do
      let(:raw_data) do
        {
          'last_activity_date' => Time.now.utc.iso8601,
          'matches' => [
            {
              '_id' => '3',
              'messages' => [
                {
                  '_id' => '098',
                  'to' => prospect.tinder_id,
                  'from' => account.tinder_id,
                  'message' => 'ohai',
                  'created_date' => Time.now.utc.iso8601
                }
              ],
            }
          ]
        }
      end

      let!(:message) do
        Message.create(tinder_id: '098',
                       to_tinder_id: prospect.tinder_id,
                       from_tinder_id: account.tinder_id,
                       text: 'ohai',
                       person: prospect)
      end

      it 'skips it and doesn\'t create it again' do
        expect { ProcessUpdatesWorker.new.perform(update.id) }.to change { Message.count }.by(0)
      end
    end

    context 'when message is new' do
      let(:raw_data) do
        {
          'last_activity_date' => Time.now.utc.iso8601,
          'matches' => [
            {
              '_id' => '3',
              'messages' => [
                {
                  '_id' => '098',
                  'to' => prospect.tinder_id,
                  'from' => account.tinder_id,
                  'message' => 'ohai',
                  'created_date' => Time.now.utc.iso8601
                }
              ],
            }
          ]
        }
      end

      it 'creates the message' do
        expect { ProcessUpdatesWorker.new.perform(update.id) }.to change { Message.count }.by(1)
      end
    end
  end
end
