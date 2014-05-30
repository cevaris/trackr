namespace :aws do



  task :volume => :environment do
    include AwsHelper

    client = Ec2Volume.new()
    puts client.inspect
    # client.create()



  end


  
end