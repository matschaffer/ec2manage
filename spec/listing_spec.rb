require 'spec_helper'

describe EC2Manage::Lister do
  Lister = EC2Manage::Lister

  it "should organize the output of describe_instances" do
    mock_connection = mock('connection')
    mock_connection.expects(:describe_instances).returns(YAML.load_file('spec/fixtures/describe_instances.yml'))
    @lister = Lister.new(mock_connection, nil)    
    @lister.list
  end

  it "should send organized output to the UI" do
  end
end
