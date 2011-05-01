# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "interpreter/version"

Gem::Specification.new do |s|
  s.name        = "interpreter"
  s.version     = Interpreter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jagdeep Singh"]
  s.email       = ["jagdeepkh@gmail.com"]
  s.homepage    = "https://github.com/jagdeep/interpreter"
  s.summary     = %q{Provides an interface for managing translations}
  s.description = %q{Use this to manage translations for different parts of application.}

  s.rubyforge_project = "interpreter"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
