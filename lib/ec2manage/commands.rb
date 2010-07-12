require 'ec2manage'
require 'commander/import'
require 'ec2manage/commander_ext'

program :name,        EC2Manage.name
program :version,     EC2Manage.version
program :description, EC2Manage.summary

default_command :help

command :create do |c|
  c.syntax      = '[options]'
  c.summary     = 'Create an instance.'
  c.description = 'Creates an EC2 instance according to the specified options.'

  c.option '-t', '--template STRING',    'JSON template to use when creating the instance.'
  c.option '-n', '--name STRING',        'Nickname for the instance.'
  c.option '-c', '--command STRING',     'Command to run after finishing.'
  c.option '-z', '--zone STRING',        'Zone in which to create the instance (and volumes).'
  c.option '-a', '--ami STRING',         'Image to use for the instance.'
  c.option '-k', '--keypair STRING',     'Keypair to install on the instance.'
  c.option '-g', '--group STRING',       'Security group to use on the instance.'
  c.option '-v', '--volume-size STRING', 'Size of volume to attach in GB.'
  c.option '-s', '--snapshot STRING',    'Snapshot to use for the volume.'
  c.option '-d', '--device STRING',      'Device to attach the volume on.'

  c.action do |args, options|
    options.default :template => 'default'
    
    #EC2Manage::Structure.new(options.__hash__)
    #EC2Manage::Creator.new(structure, self).run

    say "hello creation of template: #{options.template}"
  end
end

command :list do |c|
  c.summary     = 'List all instances.'
  c.description = 'Lists all instances associated with the current account.'

  c.action do |args, options|
    say "hello listing"
  end
end

command :rename do |c|
  c.summary     = 'Rename an instance or volume.'
  c.description = 'Renames the specified instance or volume.'
  c.syntax      = '<old-name> <new-name>'

  c.action do |args, options|
    old_name = args.shift or raise 'Please specify an instance or volume to rename'
    new_name = args.shift or raise 'Please specify a new name for this instance or volume'
    say "hello rename"
  end
end

command :delete do |c|
  c.summary     = 'Delete an instance or volume.'
  c.description = 'Deletes the specified instance or volume.'
  c.syntax      = '<name> [options]'

  c.option '-v', '--volumes', 'Also delete any associated volumes.'

  c.action do |args, options|
    name = args.shift or raise 'Please specify an instance or volume to delete'
    say "hello delete"
  end
end
