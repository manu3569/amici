class ApplicationController < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  set :views, Proc.new { File.join(root, "../views/") }

  def self.get_or_post(url, &block)
    get(url, &block)
    post(url, &block)
  end

end
