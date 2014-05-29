namespace :aws do



  task :volume => :environment do
    include AwsHelper

    client = AwsHelper::Ec2Volume()
    # client.create()



  end


  
end