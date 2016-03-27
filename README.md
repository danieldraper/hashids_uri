[![Build Status](https://travis-ci.org/danieldraper/hashids_uri.svg)](https://travis-ci.org/danieldraper/hashids_uri)
[![Dependency Status](https://gemnasium.com/danieldraper/hashids_uri.svg)](https://gemnasium.com/danieldraper/hashids_uri)
[![Code Climate](https://codeclimate.com/github/danieldraper/hashids_uri/badges/gpa.svg)](https://codeclimate.com/github/danieldraper/hashids_uri)

# HashidsUri

HashidsUri allows you to easily use [Hashids](http://hashids.org/) in your Ruby on Rails URLs via the [Hashids Gem](https://github.com/peterhellberg/hashids.rb). You no longer need to expose sequential IDs to your users and you can do all this without changing your primary key to a UUID or some custom database level function.

An example URL using HashidsUri
```http
https://example.com/lejRej
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hashids_uri'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hashids_uri

## Usage

Getting started is easy, you include the following in your model:

```ruby
def User < ActiveRecord::Base
    has_hashids_uri
end
```

You will also need to create a database column called `hashid`, this was added
to improve performance:

    $ bin/rails g add_hashid_to_users hashid:string:uniq

By default the underlying Hashids gem does not provide a unique salt when creating a hash, this will lead to the same hash for each model with the same ID. If you require a unique hash you can provide a salt when initializing HashidsUri.

```ruby
def User < ActiveRecord::Base
    has_hashids_uri salt: '1ac206225a7806'
end
```

You can also specify the minimum length your hash should be by passing the `min_length` option during initialization.

```ruby
def User < ActiveRecord::Base
    has_hashids_uri min_length: 6
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/danieldraper/hashids_uri. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

