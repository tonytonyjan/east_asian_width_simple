# frozen_string_literal: true

def gem_name(gem_name)
  "#{gem_name} v#{Gem.loaded_specs[gem_name].version}"
end
