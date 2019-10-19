require 'minitest/autorun'
require 'alexarb'

def load_fixture(scenario)
  File.read File.join File.dirname(__FILE__), 'fixtures', "#{scenario}.json"
end

def ignore_whitespaces(str)
  str.gsub(/\s+/, '')
end
