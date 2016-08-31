# Followanalytics

Welcome to the FollowAnalytics gem. It will allow to to use the FollowAnalytics Platform API

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'followanalytics'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install followanalytics

## Usage

### Configuration

```ruby
# In an initializer:
Followanalytics.configure do |config|
  config.api_key = ENV['FA_API_KEY']
end
```

### Using the attributes

#### Create a client
```ruby
client = Followanalytics::Attributes::Client.new(sor_identifier)
```

#### Setting a value to a predefined attribute
```ruby
client.set_first_name("Tim", "customer-00001")
```

#### Setting a value to a custom attribute
```ruby
client.set_value("apple", "favorite_fruit", "customer-00001")
```

#### Unsetting an attribute value
```ruby
client.unset_value("favorite_fruit", "customer-00001")
```

#### Adding a value to an attribute of type set
```ruby
client.add_set_value("strawberry", "fruit_salad", "customer-00001")
```

#### Removing a value to an attribute of type set
```ruby
client.remove_set_value("strawberry", "fruit_salad", "customer-00001")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/followanalytics.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

