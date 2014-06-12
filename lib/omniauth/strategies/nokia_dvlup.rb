require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    class NokiaDVLUP < OmniAuth::Strategies::OAuth2
      BASIC_SCOPE = "basic"
      CODE_RESPONSE_TYPE = "code"

      option :name, "dvlup"
      option :client_options, {
        :site => "https://www.dvlup.com/api",
        :authorize_url => "https://accounts.dvlup.com/auth",
        :token_url => "https://accounts.dvlup.com/auth/token"
      }
      option :redirect_uri

      uid { self.raw_info['id'] }

      info do
        {
          :username => self.raw_info['username'],
          :first_name => self.raw_info['firstName'],
          :last_name => self.raw_info['lastName'],
          :country => self.raw_info['country'],
          :total_apps => self.raw_info['totalApps'],
          :total_points => self.raw_info['totalPoints'],
          :total_xp => self.raw_info['totalXP'],
          :total_badges => self.raw_info['totalBadges'],
          :platforms => self.raw_info['platforms'],
        }
      end

      extra do
        {
          :raw_info => self.raw_info
        }
      end

      def authorize_params
        super.tap do |params|
          params[:scope] = BASIC_SCOPE
          params[:response_type] = CODE_RESPONSE_TYPE
          params[:redirect_uri] = options[:redirect_uri]
        end
      end

      def raw_info
        if @raw_info.nil?
          details = self.access_token.get("https://www.dvlulp.com/api/users/details").parsed
          apps = self.access_token.get("https://www.dvlulp.com/api/users/apps").parsed.map do |result|
            {
              :app_id => result['appId'],
              :title => result['title'],
              :platform => result['platform'],
              :business_model => result['businessModel'],
            }
          end
          @raw_info = details.merge({:apps => apps})
        end
        return @raw_info
      end
    end
  end
end

OmniAuth.config.add_camelization('dvlup', 'DVLUP')
