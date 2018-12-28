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
    spec.description = 'A ruby client for the Autotask API'
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

    spec.add_runtime_dependency 'activesupport'
    spec.add_runtime_dependency 'savon'

    spec.add_development_dependency 'awesome_print'
    spec.add_development_dependency 'bundler'
    spec.add_development_dependency 'byebug'
    spec.add_development_dependency 'guard'
    spec.add_development_dependency 'guard-rspec'
    spec.add_development_dependency 'rubocop-rspec'
    spec.add_development_dependency 'rake'
    spec.add_development_dependency 'rspec'
    spec.add_development_dependency 'rubocop'
    spec.add_development_dependency 'webmock'
end