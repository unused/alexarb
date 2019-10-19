require_relative './test_helper'

class TestSupport < Minitest::Test
  def subject
    Alexarb::Support
  end

  def test_snakecase
    assert_equal 'snakeCase', subject.snakecase('snake_case')
  end

  def test_underscore
    assert_equal 'snake_case', subject.underscore('snakeCase')
  end

  def test_snakecase_keys
    hash = { foo: 1, foo_bar: 2, bar: { foo_bar: 3 } }
    hash = subject.snakecase_keys hash
    assert_equal hash.keys, %i[foo fooBar bar]
    assert_equal hash[:bar].keys, %i[fooBar]
  end

  def test_underscore_keys
    hash = { foo: 1, fooBar: 2, bar: { fooBar: 3 } }
    hash = subject.underscore_keys hash
    assert_equal hash.keys, %i[foo foo_bar bar]
    assert_equal hash[:bar].keys, %i[foo_bar]
  end
end
