class Setup < Sequel::Model

  

  def self.done?
    Setup.count > 0
  end

end