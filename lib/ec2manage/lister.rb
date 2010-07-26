class EC2Manage::Lister
  def initialize(connection)
    @connection = connection
  end

  def list
    { 'instances' => instances }
  end

  def instances
    @connection.describe_instances.map do |i|
      data = { 'zone'    => i[:aws_availability_zone],
               'ami'     => i[:aws_image_id],
               'keypair' => i[:ssh_key_name],
               'groups'  => i[:aws_groups] }

      data['volumes'] = map_volumes(i[:block_device_mappings]) if i[:block_device_mappings]

      data
    end
  end

  def map_volumes(volumes)
    volumes.map do |v|
      { 'device' => v[:device_name] }
    end
  end
end
