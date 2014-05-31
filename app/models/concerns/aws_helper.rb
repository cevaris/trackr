module AwsHelper

  class Ec2Volume
  end

  class Ec2Volume

    attr_accessor :client, :volume, :instance

    def initialize()
      @client = AWS::EC2.new(
        :access_key_id => ENV['ACCESS_KEY_ID'],
        :secret_access_key => ENV['SECRET_ACCESS_KEY'])
      @instance = @client.instances[ENV['EC2_INSTANCE']]
    end

    def volumes
      @instance ? @instance.attachments : []
    end

    def volume(vol_id) 
      raise 'Client not found' unless @client

      if @client.volumes[vol_id].exists?
        @client.volumes[vol_id]
      else
        raise "Could not locate volume #{vol_id}"  
      end
      
    end

    def create(size=10)
      raise 'Client not found' unless @client

      @volume = @client.volumes.create(size: size, availability_zone: ENV['AWS_ZONE'])
      sleep 2;puts @volume.status until @volume.status != :creating
      @volume
    end

    def attach(instance, volume, path)
      response = volume.attach_to(instance, path)
      sleep 2;puts response.status until (response.exists? and response.status == :attached)
    end

    def detach(instance, volume, path)
      response = volume.detach_from(instance, path, force: true)
      begin
        sleep 2;puts response.status until response.status != :detaching
      rescue AWS::Core::Resource::NotFound
        # Because there is a bug....
      end      
    end
  end
end
