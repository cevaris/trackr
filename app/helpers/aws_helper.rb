module AwsHelper
  class Ec2Volume
    def initialize()
      @ec2 = AWS::EC2.new(
        :access_key_id => ENV['ACCESS_KEY_ID'],
        :secret_access_key => ENV['SECRET_ACCESS_KEY'])
    end
    def create(size=10, availability_zone='us-east-1')
      volume = ec2.volumes.create(:size => size, :availability_zone => availability_zone)
      attachment = volume.attach_to(ec2.instances['i-de78ed8d'], "/dev/xdf33") 
    end
  end
end
