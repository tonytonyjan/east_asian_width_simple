# frozen_string_literal: true

require_relative 'helpers'
require 'benchmark/ips'
require 'east_asian_width_simple'
require 'east_asian_width'
require 'unicode/eaw'

char = 'ア'
eaws = EastAsianWidthSimple.new(File.open("#{__dir__}/../test/EastAsianWidth.txt"))
Benchmark.ips do |x|
  x.report('east_asian_width_simple') { eaws.lookup(char.ord) }
  x.report(gem_name('east_asian_width')) { EastAsianWidth.east_asian_width(char) }
  x.report(gem_name('unicode-eaw')) { Unicode::Eaw.property(char) }
  x.compare!
end
