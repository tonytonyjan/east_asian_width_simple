# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = 'east_asian_width_simple'
  spec.version = '1.0.0'
  spec.authors = ['Weihang Jian']
  spec.email = ['tonytonyjan@gmail.com']
  spec.summary = <<~SUMMARY
    Calculate string visual width by looking up EastAsianWidth.txt \
    from UAX #11: East Asian Width
  SUMMARY
  spec.description = <<~DESCRIPTION
    east_asian_width_simple is a Ruby gem that calculates the visual width of \
    strings by parsing and looking up East Asian Width Property Data File, \
    aka EastAsianWidth.txt, \
    which is defined in Unicode Standard Annex #11: East Asian Width. \
    It aims to be time-efficient and easy to use.
  DESCRIPTION
  spec.homepage = 'https://github.com/tonytonyjan/east_asian_width_simple'
  spec.license = 'MIT'
  spec.files = ['lib/east_asian_width_simple.rb']
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
