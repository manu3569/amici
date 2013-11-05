class AuthorizationController < ApplicationController

  get '/sign-up/?' do
    params = { client_id: CLIENT_ID, scope: "repo" }
    # TODO implement state to fight CSFR
    uri = "https://github.com/login/oauth/authorize/?" + URI.encode_www_form(params)
    erb :sign_up, :locals => { :uri => uri }
  end

  get '/sign-up/callback/?' do
      
    temporary_code = params[:code]
    uri = URI('https://github.com/login/oauth/access_token/')
    header = { 'Accept' => 'application/json' }
    values = { 'client_id' => CLIENT_ID,
               'client_secret' => CLIENT_SECRET,
               'code' => temporary_code }

    request = Net::HTTP::Post.new('https://github.com/login/oauth/access_token/', header)
    request.form_data = values
    
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      response = http.request(request)
      @student = Student.create(:token => JSON.parse(response.body)["access_token"])
    end

    @student.update_info

    "<h1>Welcome to amici, #{@student.first_name}</h1>"
  
  end

end