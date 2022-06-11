# frozen_string_literal: true

require_relative 'helpers'
require 'benchmark/ips'
require 'east_asian_width_simple'
require 'east_asian_width'
require 'reline'
require 'unicode/display_width'
require 'visual_width'

text = '￠￦｡ￜㄅ뀀¢⟭a'
eaws = EastAsianWidthSimple.new(
  File.open("#{__dir__}/../test/EastAsianWidth.txt")
)

Benchmark.ips do |x|
  x.report('east_asian_width_simple') { eaws.string_width(text) }
  x.report(gem_name('east_asian_width')) { EastAsianWidth.length(text) }
  x.report(gem_name('reline')) { Reline::Unicode.calculate_width(text) }
  x.report(gem_name('unicode-display_width')) { Unicode::DisplayWidth.of(text) }
  x.report(gem_name('visual_width')) { VisualWidth.measure(text) }
  x.compare!
end
