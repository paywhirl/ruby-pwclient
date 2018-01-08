# PayWhirl

**This library is currently in development**
PayWhirl's Ruby library is provided for developers to easily interface with PayWhirl's services.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'paywhirl'
```

And then execute:

    $ bundle

Or install it yourself with the following:

    $ gem install paywhirl

## Usage

[get your API keys by signing up here](https://app.paywhirl.com/)

```ruby
require "paywhirl"

api_key = "pwpk_xxxxxxxxxxxxxxx"
api_secret = "pwpsk_xxxxxxxxxxx"

paywhirl = PayWhirl.new(api_key, api_secret)
```

[Full docs](https://api.paywhirl.com)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/paywhirl/ruby-pwclient

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
