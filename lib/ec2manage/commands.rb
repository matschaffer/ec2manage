require 'ec2manage'
require 'commander/import'
require 'ec2manage/ext/commander'
require 'ec2manage/ext/highline'

program :name,        EC2Manage.name
program :version,     EC2Manage.version
program :description, EC2Manage.summary

default_command :help

def connection
  EC2Manage::Connection.new(self).connection
end

command "create-instance" do |c|
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
    structure = EC2Manage::Structure.new(self, options.__hash__)
    say "hello creation of template: #{structure.path}"
  end
end

command "create-keypair" do |c|
  c.syntax = '<name>'
  c.summary = 'Create a keypair.'
  c.description = 'Creates a keypair with the specified name and writes it to ~/.ssh.'

  c.action do |args|
    name = args.shift or raise 'Please specify a name for this keypair.'
    keypair = connection.create_key_pair(name)
    EC2Manage::KeyManager.new.store(keypair)
  end
end

command :list do |c|
  c.summary     = 'List all instances.'
  c.description = 'Lists all instances associated with the current account.'

  c.action do |args, options|
    jj EC2Manage::Lister.new(connection).list
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
