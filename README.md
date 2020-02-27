# AParserClient

[![Gem Version](https://badge.fury.io/rb/a_parser_client.svg)](https://badge.fury.io/rb/a_parser_client)

Ruby client for A-Parser user API.

This is a test release, more API coverage is upcoming.

Covered for now:

-	ping
-	info
- 	getTaskList
-	getTaskState
-	getTaskConf
-	addTask
-	changeTaskStatus
-	getAccountsCount	
-	getProxies	
-	update	
-	getTaskResultsFile	
-	deleteTaskResultsFile	
-	moveTask	
-	getParserInfo	
-	getParserPreset	
-	oneRequest
-	bulkRequest

TODO:

Some automation procedures:

-	multitasks operations (like stop all tasks etc.)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'a_parser_client'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install a_parser_client

## Usage

There will be a wiki page soon.

The code sample below is all for now...

```ruby
require 'a_parser_client'

 api = AParserClient::API.new 'http://<your_host_running_aparser>:9091/API, ''
 api.ping

=> {"success" : 1, "data" : "pong"}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yvshevchenko/a_parser_client. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the AParserClient project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/yvshevchenko/a_parser_client/blob/master/CODE_OF_CONDUCT.md).
