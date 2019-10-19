require 'json'
require 'time'

module Alexarb
  # Request provides a ruby-like interface to access echo request data.
  class Request
    attr_reader :raw

    def initialize(data)
      data = JSON.parse data unless data.respond_to? :each_pair
      @raw = Support.underscore_keys data
    end

    def fetch(*args)
      @raw.dig(*args)
    end

    def type
      fetch :request, :type
    end

    def intent
      fetch :request, :intent, :name
    end

    def slots
      @slots ||= fetch(:request, :intent, :slots).tap do |slots|
        return unless slots

        slots.each_pair do |key, value|
          slots[key] = value[:value]
        end
      end
    end

    def slot?(key)
      slots&.key? key
    end

    def slot(key)
      return unless slot? key

      slots[key]
    end

    def app_id
      fetch :context, :system, :application, :application_id
    end

    def device_id
      fetch :context, :system, :device, :device_id
    end

    def user_id
      fetch :context, :system, :user, :user_id
    end
    alias whoami user_id

    def request_id
      fetch :request, :request_id
    end

    def timestamp
      Time.parse(fetch(:request, :timestamp)).utc
    end

    def locale
      fetch :request, :locale
    end

    def content
      fetch :content
    end
  end
end
