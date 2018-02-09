require 'rails_helper'
RSpec.describe Replied do
  let!(:account) do
    create(:account, tinder_id: '1')
  end

  let!(:replied) do
    create(:replied, tinder_id: '2', account: account)
  end

  describe 'advance_stage' do
    context 'when stage is advanceable' do
      let!(:sent_message2) do
        create(:message,
               from_tinder_id: account.tinder_id,
               to_tinder_id: replied.tinder_id,
               person: replied)
      end
      let!(:received_message) do
        create(:message,
               from_tinder_id: replied.tinder_id,
               to_tinder_id: account.tinder_id,
               person: replied)
      end
      let!(:sent_message) do
        create(:message,
               from_tinder_id: account.tinder_id,
               to_tinder_id: replied.tinder_id,
               person: replied)
      end
      let!(:received_message2) do
        create(:message,
               from_tinder_id: replied.tinder_id,
               to_tinder_id: account.tinder_id,
               person: replied)
      end

      it 'changes the type to responsive' do
        replied.advance_stage
        replied.save
        expect(Person.find(replied.id).class).to eq(Responsive)
      end
    end

    context 'when stage is not advanceable' do
      let!(:sent_message) do
        create(:message,
               from_tinder_id: account.tinder_id,
               to_tinder_id: matched.tinder_id,
               person: matched)
      end
      let!(:received_message) do
        create(:message,
               from_tinder_id: replied.tinder_id,
               to_tinder_id: account.tinder_id,
               person: replied)
      end
      let!(:sent_message) do
        create(:message,
               from_tinder_id: account.tinder_id,
               to_tinder_id: replied.tinder_id,
               person: replied)
      end

      it 'does not change its type' do
        replied.advance_stage
        replied.save
        expect(Person.find(replied.id).class).not_to eq(Responsive)
      end
    end
  end
end
