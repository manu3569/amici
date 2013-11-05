class AuthorizationController < ApplicationController

  get '/sign-up/?' do
    params = { client_id: CLIENT_ID, scope: "repo" }
    # TODO implement state to fight CSFR
    uri = "https://github.com/login/oauth/authorize/?" + URI.encode_www_form(params)
    erb :sign_up, :locals => { :uri => uri }
  end

  get '/sign-up/callback/?' do

    begin
      
      temporary_code = params[:code]
      uri = URI('https://github.com/login/oauth/access_token/')
      header = { 'accept' => 'json' }
      values = { :client_id => CLIENT_ID,
                 :client_secret => CLIENT_SECRET,
                 :code => temporary_code }
      
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Post.new('https://github.com/login/oauth/access_token/', header)
        request.set_form_data = values
        response = http.request(request)  
        JSON.parse(response.body)
      end

    rescue Exception => e

      "Message: " + e.message + "<br/>" + "Backtrace: " + e.backtrace.inspect
    
    end
  
  end

end