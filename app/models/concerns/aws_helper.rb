module AwsHelper
  class Ec2Volume

    attr_accessor :client

    def initialize()
      @client = AWS::EC2.new(
        :access_key_id => ENV['ACCESS_KEY_ID'],
        :secret_access_key => ENV['SECRET_ACCESS_KEY'])
      @instance = @client.instances[ENV['EC2_INSTANCE']]
    end

    def instance
      @instance if @instance
    end

    def create(size=10, availability_zone='us-east-1')
      volume = @client.volumes.create(:size => size, :availability_zone => availability_zone)
      attachment = volume.attach_to(@client.instances['i-de78ed8d'], "/dev/xdf33") 
    end
  end
end
