require 'spec_helper'

describe EC2Manage::Connection do
  Connection = EC2Manage::Connection

  before do
    @mock_ui = mock('ui')
    @example_credentials = { "access_key_id" => "AKIBLAHBLAH",
                             "secret_access_key" => "+secret+blahblah" }
  end

  it "should read access and secret from JSON in home directory" do
    File.expects(:exist?).with(Connection.credentials_path).returns(true)
    File.expects(:read).with(Connection.credentials_path).returns(@example_credentials.to_json)
    Connection.new(@mock_ui).connection.should_not be_nil
  end

  it "should assist the user in storing the credentials when the file doesn't exist" do
    File.expects(:exist?).with(Connection.credentials_path).returns(false)

    @mock_ui.expects(:say).at_least_once
    @mock_ui.expects(:color).at_least_once
    @mock_ui.expects(:ask).returns('mock_input').twice

    FileUtils.expects(:mkdir_p)
    File.any_instance.expects(:print)

    Connection.new(@mock_ui).connection
  end
end
