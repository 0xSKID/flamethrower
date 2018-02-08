require 'rails_helper'
RSpec.describe 'ProcessUpdatesWorker' do
  let(:account) do
    Account.create
  end

  context 'when there is no data to process' do
  end

  context 'when there is data to process' do
    context 'when match is invalid' do
    end

    context 'when message already exists' do
    end

    context 'when message is new' do
    end
  end
end
