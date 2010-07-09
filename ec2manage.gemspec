require File.join(File.dirname(__FILE__), 'lib', 'ec2manage')

Gem::Specification.new do |s|
  s.name        = EC2Manage.name
  s.version     = EC2Manage.version
  s.summary     = EC2Manage.summary
  s.description = EC2Manage.description

  s.add_dependency("commander", "= 4.0.2")
  s.add_dependency("json", "= 1.4.3")
  s.add_dependency("right_aws", "= 2.0.0")

  s.add_development_dependency('rspec')

  s.files       = Dir['README.md', 'bin/*', 'lib/**/*.rb'].to_a
  s.bindir      = 'bin'
  s.executables = 'ec2manage'
  s.has_rdoc    = false
  s.author      = "Mat Schaffer"
  s.email       = "mat@schaffer.me"
  s.homepage    = "http://github.com/matschaffer/ec2manage"

  s.rubyforge_project = "suppress_warnings"
end
