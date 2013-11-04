class ApplicationController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  enable  :sessions, :logging, :dump_errors
  
  set :views, Proc.new { File.join(root, "../views/") }

  def self.get_or_post(url, &block)
    get(url, &block)
    post(url, &block)
  end

end
