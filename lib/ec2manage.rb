module EC2Manage
  def self.version
    '0.0.2'
  end

  def self.name
    'ec2manage'
  end

  def self.summary
    'A command-line manager for EC2 instances.'
  end

  def self.description
    <<-EOS.gsub('      ','')
      ec2manage is a command line tool for managing EC2 instances.

      It's main goal is to provide the same style of control as the
      Amazon EC2 API Tools but with additional structure and metadata
      make administrative decisions easier.
    EOS
  end

  def self.building?
    $0.include?("gem") && ARGV[0] == "build"
  end
end

require 'ruby-debug'
raise 'Take out the debugger!' if EC2Manage.building?
