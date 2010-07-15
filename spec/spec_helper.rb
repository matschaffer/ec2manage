$: << File.join(File.dirname(__FILE__), '..', 'lib')

require 'ec2manage'
require 'mocha'
require 'spec/adapters/mock_frameworks/mocha'

# This is Rubinius-specific
require 'debugger'
