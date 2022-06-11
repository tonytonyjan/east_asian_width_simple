# frozen_string_literal: true

class EastAsianWidthSimple
  Error = Class.new(StandardError)
  MissingCodePointError = Class.new(Error)

  HEX_DIGIT_REGEXP = /\h/
  PROPERTY_TO_WIDTH_MAP = { A: nil, F: 2, H: 1, N: nil, Na: 1, W: 2 }.freeze
  DEFAULT_LOOKUP_TABLE_SIZE = 2**21

  def initialize(east_asian_width_txt_io)
    @lookup_table = Array.new(DEFAULT_LOOKUP_TABLE_SIZE)
    east_asian_width_txt_io.each_line do |line|
      next unless line.start_with?(HEX_DIGIT_REGEXP)

      codepoint, property = line.split(' ').first.split(';')
      if codepoint.include?('..')
        first, last = codepoint.split('..')
        @lookup_table.fill(property.to_sym, first.to_i(16)..last.to_i(16))
      else
        @lookup_table[codepoint.to_i(16)] = property.to_sym
      end
    end
  end

  def string_width(string)
    string = string.encode(Encoding::UTF_8) unless string.encoding == Encoding::UTF_8
    string.codepoints.sum { |codepoint| lookup_width(codepoint) }
  end

  def lookup_width(codepoint)
    property = lookup(codepoint)
    width = PROPERTY_TO_WIDTH_MAP[property]
    if width.nil?
      warn <<~WARNING_MESSAGE
        The code point 0x#{codepoint.to_s(16)} has the property "#{property}" \
        whose width is unknown.
      WARNING_MESSAGE
      return 1
    end
    width
  end

  def lookup(codepoint)
    ret = @lookup_table[codepoint]
    if ret.nil?
      raise(
        MissingCodePointError,
        "Cannot find the code point 0x#{codepoint.to_s(16)} " \
        'in the lookup table.'
      )
    end

    ret
  end

  def inspect
    "#<#{self.class}:#{object_id}>"
  end
end
