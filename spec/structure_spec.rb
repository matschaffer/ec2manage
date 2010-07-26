require 'spec_helper'

describe EC2Manage::Structure do
  Structure = EC2Manage::Structure

  before do
    @template = File.join(File.dirname(__FILE__), 'fixtures', 'default.json')
    @structure = Structure.new(:template => @template)
  end

  it "should add .json extension to a template file if not provided" do
    @structure.ensure_extension('default').should =~ /default.json$/
  end

  it "should look for template files in ~/.ec2manage if not in current pwd" do
    mock_path = mock('Pathname(default)')
    mock_path.expects(:exist?).returns(false)
    mock_path.expects(:basename).returns('default.json')

    resolved = @structure.resolve(mock_path)
    resolved.should == File.join(ENV['HOME'], '.ec2manage', 'default.json')
  end

  it "should read in the base structure from the provided template file" do
    s = Structure.new(:template => @template)

    s.zone.should         == 'us-east-1d'
    s.ami.should          == 'ami-bb709dd2'
    s.keypair.should      == 'my-keypair'
    s.groups.first.should == 'web'

    s.volumes.size.should == 1
    v = s.volumes.first
    v.size.should     == 10
    v.snapshot.should == 'snap-6a0a8c0'
    v.device.should   == 'sdi'
  end

  it "should override basic template attributes if provided with other constructor arguments" do
    s = Structure.new(:template => @template, :ami => "bob")
    s.ami.should == "bob"
  end
end
