class SetupController < ApplicationController

  get "/" do
    unless Setup.done?
      redirect "/setup"
    end
    "You're all set to go :("
  end

  #redirect_uri
  get "/setup/callback" do
    @setup = Setup[1]
    begin

    uri = URI('https://github.com/')
    header = { 'Accept' => 'application/json' }
    data   = { 'client_id' => @setup.client_id,
               'client_secret' => @setup.client_secret,
               'code' => params[:code] }
    
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      request = Net::HTTP::Post.new('/login/oauth/access_token', header)
      request.form_data = data
      response = http.request(request)
      token = JSON.parse(response.body)["access_token"]
      @setup.update(:token => token)
    end

  
    rescue Exception => e
      "Message: " + e.message + "<br><br>Backtrace: " + e.backtrace.inspect
    else
      redirect "/"
    end

  end

  get "/setup" do
    @setup = Setup[1] || Setup.create(owner_name: Setup.grab_username)
    if @setup.client_id.nil? || @setup.client_secret.nil?
      erb :"setup/get_id_and_secret"
    elsif @setup.token.nil?
      params = URI.encode_www_form({ 
        client_id: @setup.client_id, 
        scope: "repo,user:email",
        redirect_uri: Setup.auth_url
        })
      @uri = "https://github.com/login/oauth/authorize/?#{params}"
      erb :"setup/authorize_with_github"
    else
      redirect "/"
    end
  end

  post "/setup" do
    @setup = Setup.new(params[:setup])
    if @setup.save
      redirect "/setup"
    else
      erb :"setup/get_id_and_secret"
    end
  end

end