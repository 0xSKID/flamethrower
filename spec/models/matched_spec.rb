require 'rails_helper'
RSpec.describe Matched do

  before do
    allow_any_instance_of(Tinder::Client).to receive(:message)
  end

  let!(:account) do
    create(:account, tinder_id: '1')
  end

  let!(:matched) do
    create(:matched, tinder_id: '2', account: account)
  end

  describe 'advance_stage' do
    context 'when stage is advanceable' do
      let!(:sent_message) do
        create(:message,
               from_tinder_id: account.tinder_id,
               to_tinder_id: matched.tinder_id,
               person: matched)
      end
      let!(:received_message) do
        create(:message,
               from_tinder_id: matched.tinder_id,
               to_tinder_id: account.tinder_id,
               person: matched)
      end

      it 'changes the type to replied' do
        matched.advance_stage
        matched.save
        expect(Person.find(matched.id).class).to eq(Replied)
      end

      it 'sends follow up' do
        follow_up = 'Tell me something about yourself.'
        expect(matched).to receive(:send_message).with(follow_up)
        matched.advance_stage
      end
    end

    context 'when stage is not advanceable' do
      let!(:sent_message) do
        create(:message,
               from_tinder_id: account.tinder_id,
               to_tinder_id: matched.tinder_id,
               person: matched)
      end

      it 'does not change its type' do
        matched.advance_stage
        matched.save
        expect(Person.find(matched.id).class).not_to eq(Replied)
      end

      it 'does not send follow up' do
        follow_up = 'Tell me something about yourself.'
        expect(matched).not_to receive(:send_message).with(follow_up)
        matched.advance_stage
      end
    end
  end
end
