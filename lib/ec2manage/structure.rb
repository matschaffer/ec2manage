require 'pathname'
require 'json'
require 'ostruct'

class EC2Manage::Structure
  attr_reader :options

  attr_reader :zone, :ami, :keypair, :group
  attr_reader :volumes

  def initialize(options)
    @options = options
    load_template
  end

  def load_template
    data = JSON.parse(File.read(path))
    data.each do |key, value|
      instance_variable_set("@#{key}", value)
    end

    @volumes.map! { |v| OpenStruct.new(v) }
  end

  def ensure_extension(template)
    if template !~ /\.json$/
      template + '.json'
    else
      template
    end
  end

  def resolve(path)
    if path.exist?
      path.to_s
    else
      File.join(ENV['HOME'], EC2Manage.directory, path.basename)
    end
  end

  def path
    pathname = Pathname.new(ensure_extension(options[:template]))
    resolve(pathname)
  end
end
