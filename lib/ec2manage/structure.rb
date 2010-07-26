require 'pathname'
require 'json'
require 'ostruct'

class EC2Manage::Structure
  attr_reader :options

  attr_reader :zone, :ami, :keypair, :groups
  attr_reader :volumes

  def initialize(options)
    @options = options
    load_template if File.exist?(path)
    override_options
  end

  def override_options
    [:zone, :ami, :keypair, :group, :name].each do |key|
      instance_variable_set("@#{key}", options[key]) if options[key]
    end
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
      (template || 'default') + '.json'
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
