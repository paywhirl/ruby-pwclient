## A convenient PayWhirl API wrapper in Ruby

The  Ruby [PayWhirl] library is provided to allow developers to access PayWhirl
services without needing to write their own API wrappers. 

The [Documentation] linked here and below contains all of the available methods 
for interacting with your PayWhirl account. If you would like to see additional 
functionality added, feel free to submit an issue or a pull request.



  [PayWhirl]: https://app.paywhirl.com/
  [Ruby]: http://www.ruby-lang.org/en/
  [Documentation]: https://api.paywhirl.com/
### Usage Guide

- [Documentation]

## Table of Contents

- [Requirements](#requirements)
- [Installation](#installation)
- [License](#license)
- [About](#about)

## Requirements

- [Ruby] >= 1.9
- [Faraday](https://rubygems.org/gems/faraday)

## Installation

#### Suggeted installation method:
Use [RubyGems](https://rubygems.org/) and [Bundler](http://bundler.io/)

Add this line to your application's Gemfile:

```ruby
gem 'paywhirl'
```

And then execute:

    $ bundle

#### If you're not using Bundler:

    $ gem install paywhirl

## Usage

[get your API keys by signing up here](https://app.paywhirl.com/)

```ruby
require "paywhirl"

api_key = "pwpk_xxxxxxxxxxxxxxx"
api_secret = "pwpsk_xxxxxxxxxxx"

paywhirl = PayWhirl.new(api_key, api_secret)
```




## License

PayWhirl is copyright © 2016-2018 [PayWhirl Inc.][PayWhirl] This library is free
software, and may be redistributed under the terms specified in the [license].

  [license]: LICENSE.md

## About

[PayWhirl Inc.][PayWhirl] and the names and logos for PayWhirl are
trademarks of PayWhirl inc.

For additional information, please see our [Terms of Use](https://app.paywhirl.com/terms) and [Privacy Policy](https://app.paywhirl.com/privacy)
