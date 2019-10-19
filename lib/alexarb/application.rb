module Alexarb
  class Application
    BAD_REQUEST = [400, {}, []]
    RESPONSE_HEADER = { 'Content-Type' => 'application/json;charset=UTF-8' }

    @@intents = {}
    @@before_filter = []
    @@after_filter = []
    @@launch_request = nil

    attr_reader :request, :response

    alias jeff request
    alias alexa response

    def initialize(request, response)
      @request = request
      @response = response
    end

    def self.before_filter(&block)
      @@before_filter.push block
    end

    def self.after_filter(&block)
      @@after_filter.push block
    end

    def self.intent(name, &block)
      @@intents[name] = block
    end

    def self.launch_request(&block)
      @@launch_request = block
    end

    def self.call(env)
      new(Request.new(env['rack.input'].read), Response.new).call.tap do |r|
        Rails.logger.info "** Response: #{r.inspect}" # TODO: DEBUG
      end
    end

    def call
      @@before_filter.each { |block| instance_eval(&block) }
      return launch if request.type == 'LaunchRequest'
      return respond_with(response) if request.type == 'SessionEndedRequest'
      return BAD_REQUEST unless @@intents.key? request.intent

      Rails.logger.info "** Intent: #{request.intent}" # TODO: DEBUG
      instance_eval(&@@intents[request.intent || default])
      @@after_filter.each { |block| instance_eval(&block) }
      respond_with response
    end

    def launch
      instance_eval(&@@launch_request)
      respond_with response
    end

    def respond_with(response)
      [200, RESPONSE_HEADER, [response.to_json]]
    end
  end
end
