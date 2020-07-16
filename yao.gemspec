lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yao/version'

Gem::Specification.new do |spec|
  spec.name          = "yao"
  spec.version       = Yao::VERSION
  spec.authors       = ["Uchio, KONDO"]
  spec.email         = ["udzura@udzura.jp"]
  spec.summary       = %q{Yet Another OpenStack API Wrapper that rocks!!}
  spec.description   = %q{YAO is a Yet Another OpenStack API Wrapper that rocks!!}
  spec.homepage      = "https://github.com/yaocloud/yao"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json"
  spec.add_dependency "deep_merge"
  spec.add_dependency "faraday", "~> 1.0.1"
  spec.add_dependency "faraday_middleware"
end
