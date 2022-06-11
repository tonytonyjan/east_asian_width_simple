# frozen_string_literal: true

require 'rake/testtask'
require 'rubygems/package_task'

task default: :test

Rake::TestTask.new

spec = Gem::Specification.load("#{__dir__}/east_asian_width_simple.gemspec")
Gem::PackageTask.new(spec).define
