namespace :aws do
  

  namespace :ebs do

    task :create => :environment do
      include AwsHelper
      client = Ec2Volume.new
      
      volume = client.create
      puts "Created Volume #{volume.id}"
    end

    task :delete, [:id] => :environment do |task, args|
      include AwsHelper
      client = Ec2Volume.new
      
      puts "Deleting volume #{args.id}"
      volume = client.volume(args.id)
      volume.delete
      puts "Deleted Volume #{volume.id}"
    end


    task :list => :environment do
      include AwsHelper
      client = Ec2Volume.new
      
      puts client.volumes.inspect
    end

  end 


  namespace :ec2 do

    task :attach => :environment do
      include AwsHelper
      
      client = Ec2Volume.new()
      puts client.volumes

      volume = client.create()
      puts "Created Volume #{volume.id}"

      path = "/dev/sdg1"
      client.attach(client.instance, volume, path)
      puts "Attached #{volume.id} to #{client.instance.id} at device #{path}"
      puts client.volumes.inspect
    end

    task :detach => :environment do
      include AwsHelper
      
      client = Ec2Volume.new()
      puts client.volumes

      path = "/dev/sdg1"

      client.detach(client.instance, volume, path)
      puts "Detached #{volume.id} from #{client.instance.id} at device #{path}"
      puts client.volumes

      # volume.delete
      # puts "Deleted Volume #{volume.id}"
    end

  end


  


  
end