require 'right_aws'

class EC2Manage::Connection
  def self.credentials_path
    "#{ENV['HOME']}/.ec2manage/credentials"
  end

  def initialize(ui)
    @ui = ui

    if File.exist?(self.class.credentials_path)
      config = JSON.parse(File.read(self.class.credentials_path))
      @access_key_id     = config["access_key_id"]
      @secret_access_key = config["secret_access_key"]
    else
      @ui.say "<%= color('Whoops!', :bold, :red) %> I couldn't find a credentials file."
      @ui.say "We'll have to create one."
      @access_key_id     = @ui.ask("<%= color('Please enter your Access Key ID:', :bold) %>     ")
      @secret_access_key = @ui.ask("<%= color('Please enter your Secret Access Key:', :bold) %> ")

      @ui.say "Now I'll write this to " + color(self.class.credentials_path, :bold) + " for safe keeping."
      FileUtils.mkdir_p(File.dirname(self.class.credentials_path))
      File.open(self.class.credentials_path, 'w') do |f|
        f.print({"access_key_id" => @access_key_id, "secret_access_key" => @secret_access_key}.to_json)
      end
    end
  end

  def connection
    @connection = RightAws::Ec2.new(@access_key_id, @secret_access_key)
  end
end
