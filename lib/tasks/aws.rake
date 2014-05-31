namespace :aws do
  

  namespace :ebs do

    task :create => :environment do
      include AwsHelper
      client = EbsVolume.new
      
      volume = client.create
      puts "Created Volume #{volume.id}"
    end

    task :delete, [:vol_id] => :environment do |task, args|
      include AwsHelper
      client = EbsVolume.new
      
      puts "Deleting volume #{args.vol_id}"
      volume = client.volume(args.vol_id)
      volume.delete
      puts "Deleted volume #{volume.id}"
    end


    task :list => :environment do
      include AwsHelper
      client = EbsVolume.new

      client.volumes.each do |vol|
        puts "#{vol.id} : #{vol.status}"
      end
    end

  end 


  namespace :ec2 do

    task :attach, [:vol_id,:path] => :environment do |task, args|
      include AwsHelper
      
      ec2 = Ec2Instance.new
      ebs = EbsVolume.new

      puts "Fetching volume #{args.vol_id}"
      volume = ebs.volume(args.vol_id)
      puts "Found volume #{volume.id}"

      ec2.attach(ec2.instance, volume, args.path)
      puts "Attached #{volume.id} to #{ec2.instance.id} at device #{args.path}"
    end

    task :detach, [:vol_id,:path] => :environment do |task, args|
      include AwsHelper
      
      ec2 = Ec2Instance.new
      ebs = EbsVolume.new

      puts "Fetching volume #{args.vol_id}"
      volume = ebs.volume(args.vol_id)
      puts "Found volume #{volume.id}"

      ec2.detach(ec2.instance, volume, args.path)
      puts "Detached #{volume.id} from #{ec2.instance.id} at device #{args.path}"
    end

  end


  


  
end