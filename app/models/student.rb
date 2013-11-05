class Student < Sequel::Model

  one_to_many :assignment_submissions

  def update_info
    uri = URI("https://api.github.com/")

    info = nil

    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new("/user?access_token=#{self.token}")
      response = http.request(request)
      info = JSON.parse(response.body)
    end

    self.first_name, self.last_name = info["name"].split(' ', 2)
    self.email = info["email"]
    self.github_username = info["login"]
  end

end