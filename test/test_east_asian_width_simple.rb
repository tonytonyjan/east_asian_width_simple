# frozen_string_literal: true

require 'minitest/autorun'
require 'east_asian_width_simple'

class TestEastAsianWidth < Minitest::Test
  parallelize_me!

  def setup
    @eaw = EastAsianWidthSimple.new(File.open("#{__dir__}/EastAsianWidth.txt"))
  end

  def test_raise_error_when_lookup_a_missing_code_point
    assert_raises EastAsianWidthSimple::MissingCodePointError do
      @eaw.lookup(0x10FFFF)
    end
  end

  def test_string_width
    assert_string_width 27, '簡煒航 loves 焦玟綾 forever'
    assert_string_width 9, '台灣 No.1'
    assert_string_width 4, '測試'
    assert_string_width 8, '測試test'
  end

  def test_lookup_width
    assert_lookup_width 2, 'Ａ'
    assert_lookup_width 1, 'ｱ'
    assert_lookup_width 1, 'A'
    assert_lookup_width 2, '兜'
    assert_lookup_width 2, '🐞'
  end

  def test_lookup
    assert_lookup :A, 'α'
    assert_lookup :F, 'Ａ'
    assert_lookup :H, 'ｱ'
    assert_lookup :N, 'अ'
    assert_lookup :Na, 'A'
    assert_lookup :W, '兜'
    assert_lookup :W, '🐞'
  end

  def test_handle_non_unicode_encoding
    assert_string_width 6, '簡煒航'.encode(Encoding::Big5)
  end

  private

  def assert_string_width(expected, string)
    assert_equal expected, @eaw.string_width(string)
  end

  def assert_lookup_width(expected, character)
    assert_equal expected, @eaw.lookup_width(character.ord)
  end

  def assert_lookup(expected, character)
    assert_equal expected, @eaw.lookup(character.ord)
  end
end
