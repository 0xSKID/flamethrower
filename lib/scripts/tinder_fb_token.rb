# This is an example script used for development purposes
# infact its probably broken or has strange behavior
module Scripts
  class TinderFbToken
    OAUTH_LINK = 'https://www.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fau' \
                 'thorize%2F&scope=user_birthday,user_photos,user_education_history,email,user_relatio' \
                 'nship_details,user_friends,user_work_history,user_likes&response_type=token%2Csigned' \
                 '_request&client_id=464891386855067'.freeze
    USER_AGENT = 'Mozilla/5.0 (Linux; U; en-gb; KFTHWI Build/JDQ39) AppleWebKit/535.19 (KHTML' \
                 ', like Gecko) Silk/3.16 Safari/535.19'.freeze

    def self.call
      mechanize = Mechanize.new
      mechanize.user_agent = USER_AGENT

      Rails.application.secrets[facebook_accounts].each do |facebook_account|
        login_form = mechanize.get(OAUTH_LINK) do |f|
          f.email = facebook_account[:email]
          f.password = ENV["FB_PASSWORD"]
        end
        oauth_token = extract_token(login_form)

        puts "#{facebook_account[:email]} #{oauth_token}"
      end
    end

    def self.extract_token(login_form)
      login_form.submit.form.submit.body.split('access_token=')[1].split('&')[0]
    end
  end
end
