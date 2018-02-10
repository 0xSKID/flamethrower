require 'rails_helper'
RSpec.describe 'UpdatesWorker' do
  let(:account) do
    Account.create
  end

  let(:client) do
    instance_double(Tinder::Client, updates: updates)
  end

  let(:updates) do
    {
      'matches' => {
        'person' => {},
        'messages' => []
      },
      'last_activity_date' => Time.now.utc.iso8601
    }
  end

  before do
    expect(Tinder::Client).to receive(:new).and_return(client)
    expect(client).to receive(:updates).and_return(updates)
  end

  describe 'perform' do
    it 'creates an update model' do
      expect { UpdatesWorker.new.perform(account.id) }
        .to change { Update.count }.by(1)
    end

    it 'creates a raw data model' do
      expect { UpdatesWorker.new.perform(account.id) }
        .to change { RawData.count }.by(1)
    end

    it 'sends a messages to process updates worker' do
      expect(ProcessUpdatesWorker).to receive(:perform_async)
      UpdatesWorker.new.perform(account.id)
    end
  end
end
