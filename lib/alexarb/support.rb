module Alexarb
  class Support
    class << self
      def snakecase_keys(hash)
        transform_keys hash, :snakecase
      end

      def underscore_keys(hash)
        transform_keys hash, :underscore
      end

      def transform_keys(hash, method)
        {}.tap do |result|
          hash.each_pair do |key, value|
            value = transform_keys(value, method) if value.respond_to? :each_key
            new_key = public_send(method, key).to_sym
            result[new_key] = value
          end
        end
      end

      def snakecase(str)
        String(str).gsub(/_([a-z])/) { Regexp.last_match(1).upcase }
      end

      def underscore(str)
        str = String(str)
        str[0].downcase << str.slice(1, str.length).gsub(/([A-Z])/, '_\1').downcase
      end
    end
  end
end
