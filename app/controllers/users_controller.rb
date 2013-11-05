class UsersController < ApplicationController

  get  '/users/new/?' do
    params = URI.encode_www_form({ client_id: CLIENT_ID, scope: "repo" })
    @uri = "https://github.com/login/oauth/authorize/?#{params}"
    erb :"users/new"
  end

  get '/users/create/?' do
    begin
    uri = URI('https://github.com/')
    header = { 'Accept' => 'application/json' }
    data = { 'client_id' => CLIENT_ID,
               'client_secret' => CLIENT_SECRET,
               'code' => params[:code] }
    
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new('/login/oauth/access_token', header)
      request.form_data = data
      response = http.request(request)
      token = JSON.parse(response.body)["access_token"]
      @student = Student.new(:token => token)
      @student.update_info
      @student.save
    end


    "<h1>Welcome to amici, #{@student.first_name}</h1>"
  
    rescue Exception => e
      "<pre>Message: " + e.message + "\nBacktrace: " + e.backtrace.inspect
    end

  end

  get '/users/:id/?' do
    
  end


end