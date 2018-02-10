desc 'Generate Tinder accounts from Facebook credentials'
task :generate_accounts do
  Rails.application.secrets[:facebook_accounts].each do |facebook_account|
    email = facebook_account[:email]
    password = facebook_account[:password]
    oauth_token = Facebook::Client.new.get_oauth_token(email, password)
    token_response = Tinder::Client.new.get_auth_token(facebook_oauth_token, email)

    Account.build_from(token_response).tap do |account|
      account.facebook_email = email
      account.facebook_oauth_token = oauth_token
      account.save
    end
  end
end
