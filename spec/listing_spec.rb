require 'spec_helper'

describe EC2Manage::Lister do
  Lister = EC2Manage::Lister

  before do
    @mock_connection = mock('connection')
    @mock_connection.stubs(:describe_instances).returns(YAML.load_file('spec/fixtures/describe_instances.yml'))
  end

  it "should organize the output of describe_instances" do
    @lister = Lister.new(@mock_connection)
    i = @lister.list['instances'].first
    i['zone'].should == "us-east-1a"
    i['ami'].should  == "ami-c2a3f5d4"
    i['keypair'].should == ""
    i['groups'].should == ["default"]
    v = i['volumes'].first
    v['device'].should == "/dev/sda1"
  end

  it "should organize volume details into instance information for attached volumes" do
  end

  it "should show unattached volumes as a separate object" do
  end
end
