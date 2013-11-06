class Setup < Sequel::Model

  def self.client_id
    self[1].client_id
  end

  def self.client_secret
    self[1].client_id
  end

  def self.token
    self[1].client_id
  end

  def self.auth_url
    "http://#{self.ip}/setup/callback"
  end

  def self.user_auth_url
    "http://#{self.ip}/users/create"
  end

  def self.grab_username
    File.read(".git/config").match(/\[remote "origin"\]\n?.*\n?.*github.com.(.+)\/amici.git/)[1]
  end

  def self.ip
    @@ip ||= open('http://whatismyip.akamai.com').read
  end

  def self.done?
    setup = self[1]
    setup && setup.token && setup.client_id && setup.client_secret
  end

end