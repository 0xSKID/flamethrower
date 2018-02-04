module Tinder
  class ProspectFilter
    attr_reader :client, :account

    def initialize(account, client)
      @client = client
      @account = account
    end

    def call
    end

    private

  end
end
