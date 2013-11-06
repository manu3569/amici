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

    emails = nil

    header = { 'Accept' => 'application/vnd.github.v3' }
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Get.new("/user/emails?access_token=#{token}", header)
      response = http.request(request)
      emails = JSON.parse(response.body, :symbolize_names => true)
    end

    {
      first_name: first_name,
      last_name: last_name,
      email: emails.find { |e| e[:primary] }[:email],
      github_username: info["login"],
      token: token
    }
  end

end