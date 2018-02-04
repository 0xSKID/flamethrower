module Facebook
  class Client
    def get_oauth_token(facebook_email, facebook_password)
      mechanize = Mechanize.new
      mechanize.user_agent = user_agent

      login_form = mechanize.get(oauth_link).form do |f|
        f.email = facebook_email
        f.pass = facebook_password
      end

      extract_token(login_form)
    end

    private

    def extract_token(login_form)
      login_form.submit.form.submit.body.split('access_token=')[1].split('&')[0]
    end

    def oauth_link
      'https://www.facebook.com/v2.6/dialog/oauth?redirect_uri=fb464891386855067%3A%2F%2Fau' \
      'thorize%2F&scope=user_birthday,user_photos,user_education_history,email,user_relatio' \
      'nship_details,user_friends,user_work_history,user_likes&response_type=token%2Csigned' \
      '_request&client_id=464891386855067'.freeze
    end

    def user_agent
      'Mozilla/5.0 (Linux; U; en-gb; KFTHWI Build/JDQ39) AppleWebKit/535.19 (KHTML' \
      ', like Gecko) Silk/3.16 Safari/535.19'.freeze
    end
  end
end
