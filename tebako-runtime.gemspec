# frozen_string_literal: true

require_relative "lib/tebako-runtime/version"

Gem::Specification.new do |spec|
  spec.name          = "tebako-runtime"
  spec.version       = TebakoRuntime::VERSION
  spec.authors       = ["Ribose Inc."]
  spec.email         = ["open.source@ribose.com"]
  spec.license       = "BSD-2-Clause"

  spec.summary = "Run-time support of tebako exxecutable packager"
  spec.description = <<~SUM
    Tebako (https://github.com/tamatebako/tebako) is an executable packager.
    tebako-runtime gem implements adapters for Ruby gems that shall be aware
    that they run in tebako environment.
  SUM
  spec.homepage = "https://github.com/tamatebako/tebako-runtime"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tamatebako/tebako-runtime"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rubocop", "~> 1.52"
  spec.add_development_dependency "rubocop-rspec", "~> 2.23"
  spec.add_development_dependency "rubocop-rubycw", "~> 0.1"

  spec.add_development_dependency "ffi", "~> 1.15"
  spec.add_development_dependency "mn2pdf", "~> 1.79"
  spec.add_development_dependency "mnconvert", "~> 1.54"
  spec.add_development_dependency "sassc", "~> 2.4"
  spec.add_development_dependency "seven-zip", "~> 1.4"
end
