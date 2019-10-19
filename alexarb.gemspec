lib = File.expand_path 'lib', __dir__
$LOAD_PATH.unshift lib unless $LOAD_PATH.include? lib
require 'alexarb/version'

Gem::Specification.new do |spec|
  spec.name          = 'alexarb'
  spec.version       = Alexarb::VERSION
  spec.authors       = ['Christoph Lipautz']
  spec.email         = ['christoph@lipautz.org']

  spec.summary       = 'Amazon Alexa ruby wrapper and rack middleware'
  spec.description   = 'Handle alexa custom skill request and responses.'

  spec.homepage      = 'https://github.com/unused/alexarb'

  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
end
