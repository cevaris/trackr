require 'securerandom'

require 'net/http/persistent'

namespace :auth do


  def get_headers()
    url = URI.parse('http://localhost:3000/users/sign_up.json')
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    csrf = res['X-CSRF-Token']
    
    all_cookies = res.get_fields('set-cookie')
    cookies_array = Array.new
    all_cookies.each { | cookie |
        cookies_array.push(cookie.split('; ')[0])
    }
    cookies = cookies_array.join('; ')

    return {'X-CSRF-Token' => csrf, 'Cookie' => cookies}
  end

  def create_account(email, pass, headers=nil)
    headers ||= get_headers()
    headers['Content-Type'] = 'application/json'

    url = URI.parse('http://localhost:3000/users.json')
    req = Net::HTTP::Post.new(url.path, headers)
    req.body = { user: { email: email, password: pass, password_confirmation: pass } }.to_json
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    JSON.parse(res.read_body)
  end

  task :create => :environment do
    email = "#{SecureRandom.uuid[0..4]}@test.com"
    pass  = "testpass"
    headers = get_headers()
    puts create_account(email, pass, headers)
  end


  task :user => :environment do
    # email = "#{SecureRandom.uuid[0..4]}@test.com"
    # pass  = "testpass"
    id = 1
    auth_token = 'dcb00117-324c-478c-a96d-254b31599373'

    # headers ||= get_headers()
    headers = {}
    headers['Auth-Token'] = auth_token
    headers['Content-Type'] = 'application/json'

    url = URI.parse("http://localhost:3000/api/v1/user/#{id}")
    req = Net::HTTP::Get.new(url.path, headers)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    # puts JSON.parse(res.read_body)
    puts res.read_body
  end

end