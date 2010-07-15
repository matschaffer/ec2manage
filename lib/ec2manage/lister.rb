class EC2Manage::Lister
  def initialize(connection, ui)
    @connection = connection
    @ui = ui
  end

  def list
    @connection.describe_instances
  end
end
