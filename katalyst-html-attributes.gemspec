# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name    = "katalyst-html-attributes"
  spec.version = "1.0.1"
  spec.authors = ["Katalyst Interactive"]
  spec.email   = ["developers@katalyst.com.au"]

  spec.summary = "HTML Attributes utilities for use with ViewComponents"
  spec.homepage = "https://github.com/katalyst/html-attributes"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.files = Dir["{lib/katalyst}/**/*", "LICENSE", "README.md"]
  spec.require_paths = ["lib"]
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.add_dependency "activesupport"
  spec.add_dependency "html-attributes-utils"
end
