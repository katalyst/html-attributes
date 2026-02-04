# frozen_string_literal: true

# Run using bin/ci

CI.run do
  step "Setup", "bin/setup"

  step "Style: Ruby", "bundle exec rubocop --no-server"

  step "Security: Brakeman vulnerability audit", "bundle exec brakeman -q -w2 --force"

  step "Tests: rspec", "bundle exec rspec"
end
