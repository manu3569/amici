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
    data   = { 'client_id' => CLIENT_ID,
               'client_secret' => CLIENT_SECRET,
               'code' => params[:code] }
    
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new('/login/oauth/access_token', header)
      request.form_data = data
      response = http.request(request)
      token = JSON.parse(response.body)["access_token"]
      
      student_details = Student.retrieve_user_details(token)
      @student = Student.find_or_create(:token => token)
      @student.update(student_details)
    end


  
    rescue Exception => e
      "Message: " + e.message + "<br><br>Backtrace: " + e.backtrace.inspect
    
    else
      redirect "/users/#{@student.id}"
    end

  end

  get '/users/:id/?' do
    if @student = Student[params[:id]]
      "<h1>Welcome to amici, #{@student.first_name}</h1>"
    else
      "I don't know you. Create account!"
    end
  end


end