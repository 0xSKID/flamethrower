require 'rails_helper'
RSpec.describe 'TinderCronWorker' do
  describe 'perform' do
    let(:account_ids) { instance_double('ids', ids: [1, 2, 3]) }

    before do
      allow(RecommendationsWorker).to receive(:perform_async).with(account_ids)
      allow(UpdatesWorker).to receive(:perform_async).with(account_ids)
    end

    it 'sends the appropriate messages to the appropriate workers with the appropriate variabels' do
      TinderCronWorker.new.perform
    end
  end
end
