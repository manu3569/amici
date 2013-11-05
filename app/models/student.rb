class Student < Sequel::Model

  one_to_many :assignment_submissions

  def update_info
    uri = URI("https://api.github.com/user?access_token=#{self.token}")

    info = nil
    
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new(uri)
      response = http.request(request)
      info = JSON.parse(response)
    end

    first_name, last_name = info["name"].split(' ', 2)
    attributes = {
                  :first_name      => first_name,
                  :last_name       => last_name,
                  :email           => info["email"],
                  :github_username => info["login"]
                }
    self.update(attributes)
  end

end