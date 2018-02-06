require 'rails_helper'
RSpec.describe 'RecommendationsWorker' do
  let(:account) do
    Account.create
  end

  let(:client) do
    instance_double(Tinder::Client, recommendations: recommendations)
  end

  describe 'perform' do
    before do
      expect(Tinder::Client).to receive(:new).and_return(client)
    end

    context 'when recommendation timeout is reached' do
      let(:recommendations) do
        { 'message' => 'recs timeout' }
      end

      it 'does not create any prospects' do
        expect { RecommendationsWorker.new.perform(account.id) }
          .to change { Prospect.count }.by(0)
      end
    end

    context 'when everything is all nice and rosey' do
      let(:recommendations) do
        { 'results' => [
            { 'name' => 'Jessica',
              'photos' => [{ 'url' => 'yapics' }],
              '_id' => '10485104'
            }
          ]
        }
      end

      it 'creates some prospects' do
        expect { RecommendationsWorker.new.perform(account.id) }
          .to change { Prospect.count }.by(1)
      end
    end

    context 'when a recommendation already exists in the database' do
      let!(:prospect) do
        Prospect.create(account: account, tinder_id: '3')
      end

      let(:recommendations) do
        {
          'results' => [
            {
              'name' => 'Jessica',
              'photos' => [{ 'url' => 'yapics' }],
              '_id' => '3'
            }
          ]
        }
      end

      it 'does not create a new record' do
        expect { RecommendationsWorker.new.perform(account.id) }
          .to change { Prospect.count }.by(0)
      end
    end
  end
end
