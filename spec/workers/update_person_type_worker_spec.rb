require 'rails_helper'
RSpec.describe 'UpdatePersonTypeWorker' do

  let!(:account) do
    Account.create
  end

  let!(:matched) do
    Matched.create(account: account)
  end

  let(:find_double) do
    instance_double('Person::ActiveRecord_Relation', find: matched)
  end

  describe 'perform' do
    before do
      allow(Person).to receive(:includes).and_return(find_double)
    end

    it 'calls advance_stage and save on match' do
      expect(matched).to receive(:advance_stage)
      expect(matched).to receive(:save!)
      UpdatePersonTypeWorker.new.perform(matched.id)
    end
  end
end
