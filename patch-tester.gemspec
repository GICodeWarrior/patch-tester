# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'patch-tester'
  s.version     = '0.9'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Rusty Burchfield']
  s.email       = ['GICodeWarrior@gmail.com']
  s.homepage    = "http://github.com/GICodeWarrior/patch-tester"
  s.summary     = 'Bugzilla patch tester'
  s.description = 'Quick tool to pull patches from bugzilla and test them against a source checkout.'

  s.files        = Dir.glob("{bin,lib}/**/*") + %w(LICENSE README)
  s.require_path = 'lib'

  s.add_dependency('curb')
  s.add_dependency('nokogiri')
end
