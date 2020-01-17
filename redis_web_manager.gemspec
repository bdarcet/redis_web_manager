# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

# Maintain your gem's version:
require 'redis_web_manager/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = 'redis_web_manager'
  spec.version     = RedisWebManager::VERSION

  spec.authors     = ['Boris BRESCIANI', 'Benjamin DARCET', 'Olivier DUMAS', 'Sylvain KRAISIN']
  spec.email       = %w[boris2bresciani@gmail.com
                        b.darcet@gmail.com
                        dumas.olivier@outlook.fr
                        sylvain.kraisin@gmail.com]

  spec.summary     = 'rr: Summary of RedisWebManager.'
  spec.description = 'rr: Description of RedisWebManager.'
  spec.homepage    = 'https://github.com/DumasOlivier/redis_web_manager'
  spec.license     = 'MIT'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0")
                     .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
  spec.test_files = Dir['spec/**/*']

  spec.add_development_dependency 'rspec-rails', '= 4.0.0.beta3'
  spec.add_development_dependency 'simplecov', '~> 0.16'

  spec.add_dependency 'rails', '>= 5.2', '< 7'
  spec.add_dependency 'redis', '~> 4.1.0'
  spec.add_dependency 'multi_json', '~> 1.0'
end
