# AutotaskRuby

[ ![Codeship Status for trepidity/autotask_ruby](https://app.codeship.com/projects/31f37600-eacf-0136-594e-46a5d8fcc7b0/status?branch=master)](https://app.codeship.com/projects/319798)

![autotask_ruby](https://github.com/trepidity/autotask_ruby/workflows/autotask_ruby/badge.svg)

Welcome to a ruby client that interacts with the Autotask API.

I intend for this to be a full-featured Ruby Client for the API.
It's still active development, but I expect that a 1.0 will be released around February 2019.

Comments, PR's are more than welcome. I would love to hear any ideas or suggestions.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'autotask_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install autotask_ruby

## Usage

The `Client.rb` must be initialized to begin. The client class is responsible for
interacting with the API.

Every call to the Autotask API must include a 'IntegrationCode'. You can get this from Autotask.
Secondly, Autotask has multiple endpoints. Be sure to use the appropriate endpoint.

### Initializing the Client.
```ruby
AutotaskRuby::Client.new(basic_auth: [valid_api_user, valid_password],
                                 integration_code: ENV['INTEGRATION_CODE'],
                                 endpoint: endpoint)
```

### Using the find method

```ruby
client.find('Account', 296162)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/autotask_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AutotaskRuby project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/autotask_ruby/blob/master/CODE_OF_CONDUCT.md).

# Thank you.
 
Many thanks to the follow from whom I've shameless stolen code ideas.
 
* https://github.com/scoop/autotask_api
* https://github.com/TinderBox/soapforce
