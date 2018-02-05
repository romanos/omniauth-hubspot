# Omniauth::Hubspot

This Gem contains the Hubspot strategy for OmniAuth.

## Before You Begin

You should have already installed OmniAuth into your app; if not, read the [OmniAuth README](https://github.com/omniauth/omniauth) to get started.

Now sign into the [Hubspot Developer Dashboard](https://developers.hubspot.com/) and create an application. Take note of your API keys.


## Using This Strategy

First start by adding this gem to your Gemfile:

```ruby
gem 'omniauth-hubspot-full'
```

If you need to use the latest HEAD version, you can do so with:

```ruby
gem 'omniauth-hubspot-full', github: 'romanos/omniauth-hubspot'
```

Next, tell OmniAuth about this provider. For a Rails app, your `config/initializers/omniauth.rb` file should look like this:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :hubspot, 'API_KEY', 'API_SECRET', scope: 'contacts timeline'
end
```

Replace `'API_KEY'` and `'API_SECRET'` with the appropriate values you obtained earlier.

If you are using [Devise](https://github.com/plataformatec/devise) then it will look like this:

```ruby
Devise.setup do |config|
  # other stuff...

  config.omniauth :hubspot, ENV['HUBSPOT_APP_ID'], ENV['HUBSPOT_APP_SECRET'], scope: 'contacts timeline'

  # other stuff...
end
```


## Scopes
Hubspot lets you choose from a [few different scopes](https://developers.hubspot.com/docs/methods/oauth2/initiate-oauth-integration#scopes).

## Hubspot Information

Querying the access token endpoint as defined [here](https://developers.hubspot.com/docs/methods/oauth2/get-access-token-information) returns a basic hash of user info and allowed scopes.

```json
{
  "token": "CJSP5qf1KhICAQEYs-gDIIGOBii1hQIyGQAf3xBKmlwHjX7OIpuIFEavB2-qYAGQsF4",
  "user": "test@hubspot.com",
  "hub_domain": "demo.hubapi.com",
  "scopes": [
    "contacts",
    "automation",
    "oauth"
  ],
  "hub_id": 62515,
  "app_id": 456,
  "expires_in": 21588,
  "user_id": 123,
  "token_type": "access"
}
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Special Thanks

In a rush, I borrowed heavily from [kmrshntr](https://github.com/kmrshntr)'s Slack Strategy in order to make this work. Thanks!