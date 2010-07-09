Gem::Specification.new do |s|
  s.name = 'ec2manage'
  s.version = "0.0.1"
  s.summary = "A command-line manager for EC2 instances."
  s.description = <<-EOS.gsub(/ {4}/,'')
    ec2manage is a command line tool for managing EC2 instances.

    It's main goal is to provide the same style of control as the
    Amazon EC2 API Tools but with additional structure and metadata
    make administrative decisions easier.
  EOS
  
  s.add_dependency("thor", "= 0.13.7")
  s.add_dependency("json", "= 1.4.3")
  s.add_dependency("right_aws", "= 2.0.0")

  s.add_development_dependency('rspec')

  s.files       = Dir['README.md', 'bin/*', 'lib/**/*.rb'].to_a
  s.bindir      = 'bin'
  s.executables = 'ec2manage'
  s.has_rdoc    = false
  s.author      = "Mat Schaffer"
  s.email       = "mat@schaffer.me"
  s.homepage    = "http://matschaffer.com"

  s.rubyforge_project = "suppress_warnings"
end
