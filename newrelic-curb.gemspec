Gem::Specification.new do |s|
	s.name        = 'newrelic-curb'
	s.version     = '0.0.1'
	s.license     = "MIT"
	s.summary     = "Curb instrumentation for Newrelic."
	s.authors     = ["Keith Thornhill"]
	s.email       = %q{keith.thornhill@gmail.com}
	s.homepage    = "https://github.com/afex/newrelic-curb"

	s.require_paths = ["lib"]
	s.add_dependency('curb')
	s.add_dependency('newrelic_rpm')
	
	s.platform = Gem::Platform::RUBY
end