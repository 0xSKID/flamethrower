module Tinder
  class Client
    def initialize(auth_token = nil)
      @auth_token = auth_token
    end

    def get_auth_token(facebook_oauth_token, facebook_user_id)
      parse(connection.post('/auth', {
        facebook_token: facebook_oauth_token,
        facebook_id: facebook_user_id }).body)
    end

    def meta
      parse(connection.get('/meta').body)
    end

    def recommendations
      parse(connection.post('user/recs').body)
    end

    def like(id)
      parse(connection.get("like/#{id}").body)
    end

    def pass(id)
      parse(connection.get("pass/#{id}").body)
    end

    def message(id, message)
      parse(connection.post("/user/matches/#{id}", { message: message }).body)
    end

    def updates(last_activity_date = nil)
      parse(connection.post('/updates', { last_activity_date: last_activity_date }).body)
    end

    private

    def parse(json)
      JSON.parse(json)
    end

    def connection
      @connection ||= get_connection
    end

    def get_connection
      connection = Faraday.new(url: base_url) do |faraday|
        faraday.request :json
        faraday.adapter Faraday.default_adapter
      end

      connection.headers[:user_agent] = user_agent
      connection.headers['X-Auth-Token'] = @auth_token
      return connection
    end

    def base_url
      'https://api.gotinder.com'
    end

    def user_agent
      'Tinder/8.6.0 (iPhone; iOS 11.2.5; Scale/2.00)'
    end
  end
end
