# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'autotask_ruby/version'

Gem::Specification.new do |spec|
  spec.name = 'autotask_ruby'
  spec.version = AutotaskRuby::VERSION
  spec.authors = ['Jared L Jennings']
  spec.email = ['jared@jaredjennings.org']

  spec.summary = 'A ruby client for the Autotask API'
  spec.description = 'A ruby client for the Autotask API. The client tries to use a full-featured approach.'
  spec.homepage = 'https://github.com/trepidity/autotask_ruby'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['homepage_uri'] = spec.homepage
    spec.metadata['source_code_uri'] = 'https://github.com/trepidity/autotask_ruby'
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 6.0.3.2', '< 7.0.5.0'
  spec.add_runtime_dependency 'savon', '~> 2.12'

  spec.add_development_dependency 'awesome_print', '~> 1.8'
  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'byebug', '~> 11.1'
  spec.add_development_dependency 'dotenv', '~> 2.7'
  spec.add_development_dependency 'guard', '~> 2.16'
  spec.add_development_dependency 'guard-rspec', '~> 4.7'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.80'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.38'
  spec.add_development_dependency 'webmock', '~> 3.8'
end
