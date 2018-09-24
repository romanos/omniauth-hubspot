require 'omniauth/strategies/oauth2'
require 'uri'
require 'rack/utils'

module OmniAuth
  module Strategies
    class Hubspot < OmniAuth::Strategies::OAuth2
      option :name, 'hubspot'

      option :authorize_options, [:scope, :optional_scope]

      option :client_options, {
        site:           'https://api.hubapi.com',
        authorize_url:  'https://app.hubspot.com/oauth/authorize',
        token_url:      '/oauth/v1/token'
      }

      option :auth_token_params, {
        mode: :query,
        param_name: 'token'
      }

      # User ID is not guaranteed to be globally unique across all Hubspot users.
      # The combination of user ID and Hub ID, on the other hand, is guaranteed
      # to be globally unique.
      uid { "#{identity['user_id']}-#{identity['hub_id']}" }

      # Make sure to record refresh token
      credentials do
        {
          token:          access_token.token,
          refresh_token:  access_token.refresh_token,
          expires_at:     access_token.expires_at,
          expires_in:     access_token.expires_in,
          expires:        access_token.expires?
        }
      end

      # {
      #   "token": "CJSP5qf1KhICAQEYs-gDIIGOBii1hQIyGQAf3xBKmlwHjX7OIpuIFEavB2-qYAGQsF4",
      #   "user": "test@hubspot.com",
      #   "hub_domain": "demo.hubapi.com",
      #   "scopes": [
      #     "contacts",
      #     "automation",
      #     "oauth"
      #   ],
      #   "hub_id": 62515,
      #   "app_id": 456,
      #   "expires_in": 21588,
      #   "user_id": 123,
      #   "token_type": "access"
      # }

      info do
        {
          user_id:    identity['user_id'],
          user:       identity['user'],
          hub_id:     identity['hub_id'],
          hub_domain: identity['hub_domain'],
          app_id:     identity['app_id'],
          scopes:     identity['scopes']
        }
      end

      extra do
        {
          raw_info: {
            identity: identity
          }
        }
      end

      def authorize_params
        super.tap do |params|
          %w[scope optional_scope].each do |v|
            if request.params[v]
              params[v.to_sym] = request.params[v]
            end
          end
        end
      end

      def identity
        @identity ||= access_token.get("/oauth/v1/access-tokens/#{access_token.token}").parsed
      end

      #private

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end
