require 'rails_helper'
RSpec.describe Responsive do
  let(:account) do
    Account.create
  end

  let(:responsive) do
    create(:responsive, account: account)
  end

  describe 'lost!' do
    it 'changes type to lost' do
      responsive.lost!
      expect(Person.find(responsive.id).class).to be(Lost)
    end
  end

  describe 'dated!' do
    it 'changes type to dated' do
      responsive.dated!
      expect(Person.find(responsive.id).class).to be(Dated)
    end
  end
end
