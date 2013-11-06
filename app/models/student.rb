class Student < Sequel::Model

  one_to_many :assignment_submissions


  def self.retrieve_user_details(token)

    info = nil

    uri = URI("https://api.github.com")
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new("/user?access_token=#{token}")
      response = http.request(request)
      info = JSON.parse(response.body)
    end

    first_name, last_name = info["name"].split(' ', 2)

    {
      first_name: first_name,
      last_name: last_name,
      email: info["email"],
      github_username: info["login"],
      token: token
    }
  end

end