# JsonCompare

Returns the difference between two JSON files.

[![Build Status](http://travis-ci.org/a2design-company/json-compare.png?branch=master)](http://travis-ci.org/a2design-company/json-compare)
[![Dependency Status](https://gemnasium.com/a2design-company/json-compare.png?travis)](https://gemnasium.com/a2design-company/json-compare)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/a2design-company/json-compare)

## Installation

Add this line to your application's Gemfile:

    gem 'json-compare'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install json-compare

## Usage

    require 'yajl'
    require 'json-compare'

    json1 = File.new('spec/fixtures/twitter-search.json', 'r')
    json2 = File.new('spec/fixtures/twitter-search2.json', 'r')
    old, new = Yajl::Parser.parse(json1), Yajl::Parser.parse(json2)
    result = JsonCompare.get_diff(old, new)

If you want to exclude some keys from comparison use exclusion param:

    exclusion = ["from_user", "to_user_id"]
    result = JsonCompare.get_diff(old, new, exclusion)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
