# Logiku

## Set up

This gem is to be used along with Lograge, so to install add these to your Gemfile:

```ruby
gem "lograge"
gem "logiku"
```

And then execute:

    $ bundle

I recommend having the same log output for test and production environment, so apply the following settings in `config/environments/test.rb` and `production.rb`:

```ruby
  config.lograge.enabled = true
  config.lograge.formatter = Logiku::Formatters::KeyValue.new
  config.logger = ActiveSupport::Logger.new(config.paths["log"].first)
  config.logger.formatter = Logiku::Normalizers::ActiveSupport.new(Logiku::Formatters::KeyValue.new)
  config.middleware.delete ActionDispatch::DebugExceptions
  config.action_mailer.logger = nil
  config.log_level = :info
```

And finally let's customize `lograge` a bit, by adding `lograge.rb` to the `initializers`:

```ruby
Rails.application.configure do
  config.lograge.custom_options = lambda do |event|
    additions = { time: event.time.utc.iso8601(6) }

    filtered_params = event.payload[:params].except("controller", "action", "format", "protocol")
    additions[:params] = filtered_params.to_json if filtered_params.present?

    additions
  end

  config.lograge.before_format = lambda do |data, payload|
    data.except(:format, :controller, :action)
  end
end
```

## Usage

For example if you wish to log `deliver.action_mailer` events, you can do it like this:
```ruby
ActiveSupport::Notifications.subscribe "deliver.action_mailer" do |*args|
  event = ActiveSupport::Notifications::Event.new *args

  data = {
    event: event.name,
    subject: event.payload[:subject],
    to: event.payload[:to].first
  }

  Rails.logger.info data
end
```

What happens here, is that we pass a `Hash` to `Rails.logger.info`. `Logiku::Normalizers::ActiveSupport` will merge that with `severity, time, progname`, call the formatter passed to it: `Logiku::Formatters::KeyValue.new#call` and this will result in a line like this:
`"severity"="INFO" "time"="2016-12-02T13:17:37.253203Z" "event"="deliver.action_mailer" "subject"="New HomeAway invoice booking" "to"="email_3@domain.com"`

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

