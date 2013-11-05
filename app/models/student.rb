class Student < Sequel::Model

  one_to_many :assignment_submissions

  def update_info
    uri = URI("https://api.github.com/user?access_token=#{self.token}")
    response = Net::HTTP.get(uri)
    info = JSON.parse(response)
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