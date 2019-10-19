
# alexarb - Ruby wrapper to handle Amazon Alexa custom skills requests.

Handle alexa custom skill request and responses. Amazon provides some helpers
to develop Alexa skills whereas the main focus is on JavaScript. If you have a
ruby based application and you want keep a skill close to it, this library
might help you.

Happy to help, feel free to open an issue on any question.

## Usage

```ruby
# Build a handler that takes a rack request and returns a proper response.
class AlexaHandler < Alexarb::Application
  attr_accessor :user

  before_filter do
    self.user ||= User.find_or_create_by ask_id: jeff.whoami
    Rails.logger.debug "[AlexaHandler] RECEIVED #{request.raw}"
  end

  after_filter do
    Rails.logger.debug "[AlexaHandler] ANSWER #{response.to_h}"
  end

  launch_request do
    alexa.say 'hello'
  end

  intent 'AMAZON.HelpIntent' do
    alexa.say 'what?'
  end

  intent 'CustomIntent' do
    MyCustomIntentHandler.new(request, user).update alexa
  end
end

# Register a Handler in config/routes.rb on any route.
Rails.application.routes.draw do
  # ...
  mount AlexaHandler => '/alexa'
end

# or in a rack environment
AlexaHandler.call env
# or on a custom environment
AlexaHandler.new(request, response).call


# Without request handler, read a request received using...
request = Alexarb::Request.new request.body.read
request.intent
```

## Development

```sh
$ gem install minitest
$ rake test # run tests
```

## References

- [Alexa JSON Schema Reference](https://developer.amazon.com/docs/custom-skills/request-and-response-json-reference.html)
- [Handle Requests](https://developer.amazon.com/docs/custom-skills/handle-requests-sent-by-alexa.html#request-verify)
- [Request Types Reference](https://developer.amazon.com/docs/custom-skills/request-types-reference.html)
