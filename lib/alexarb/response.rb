require 'json'

module Alexarb
  class Response
    VERSION = '1.0'.freeze

    attr_accessor :keep_session, :use_ssml
    attr_writer :reprompt, :text

    def initialize(text: '', reprompt: nil, keep_session: false)
      self.text = text
      self.reprompt = reprompt
      self.keep_session = keep_session
      self.use_ssml = false
    end

    def reprompt
      { type: 'PlainText', text: @reprompt }
    end

    def text
      if @use_ssml
        { type: 'SSML', ssml: @text }
      else
        { type: 'PlainText', text: @text }
      end
    end

    def say(msg)
      @text << msg
    end

    def reprompt?
      @keep_session || !@reprompt.nil?
    end

    def response
      {}.tap do |output|
        output[:output_speech] = text
        output[:shouldEndSession] = !reprompt?
        output[:reprompt] = reprompt if reprompt?
      end
    end

    def to_h
      {
        version: VERSION,
        response: response
      }
    end

    def to_json(*_args)
      Support.snakecase_keys(to_h).to_json
    end
  end
end
