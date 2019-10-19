require_relative './test_helper'

class TestRequest < Minitest::Test
  def setup
    @request = Alexarb::Request.new load_fixture 'launch_request'
  end

  def test_intent
    skip 'TODO'
  end

  def test_type
    assert_equal 'LaunchRequest', @request.type
  end

  def test_app_id
    assert @request.app_id.start_with? 'amzn1.echo-sdk'
    assert @request.app_id.end_with? 'd00ebe'
  end

  def test_device_id
    assert_equal 'string', @request.device_id
  end

  def test_request_id
    assert @request.request_id.start_with? 'amzn1.echo-api'
    assert @request.request_id.end_with? '000000'
  end

  def test_timestamp
    assert_equal '2015-05-13', @request.timestamp.strftime('%F')
    assert_equal '12:34:56', @request.timestamp.strftime('%T')
  end

  def test_locale
    assert_equal 'string', @request.locale
  end
end
