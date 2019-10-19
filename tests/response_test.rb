require_relative './test_helper'

class TestResponse < Minitest::Test
  def setup
    @response = Alexarb::Response.new
    @response.text = 'A sample message.'
  end

  def test_plaintext
    expected = ignore_whitespaces load_fixture 'plaintext_sample'
    assert_equal expected, ignore_whitespaces(@response.to_json)
  end
end
