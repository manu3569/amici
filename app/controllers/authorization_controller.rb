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
      header = { accept: :json }
      values = { :client_id => CLIENT_ID,
                 :client_secret => CLIENT_SECRET,
                 :code => temporary_code }
      
      Net::HTTP.start(uri.host, uri.port) do |http|
        request = Net::HTTP::Post.new(uri, header)
        request.set_form_data = values
        http.use_ssl   = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        response = http.request(request)  
        JSON.parse(response.body)
      end

    rescue Exception => e

      "Message: " + e.message + "<br/>" + "Backtrace: " + e.backtrace.inspect
    
    end
  
  end

end