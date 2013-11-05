class AuthorizationController < ApplicationController

  get '/sign-up/?' do
    params = { client_id: CLIENT_ID, scope: "repo" }
    # TODO implement state to fight CSFR
    uri = "https://github.com/login/oauth/authorize/?" + URI.encode_www_form(params)
    erb :sign_up, :locals => { :uri => uri }
  end

  get '/sign-up/callback/?' do
    temporary_code = request.env['rack.request.query_hash']["code"]

    uri = URI('https://github.com/login/oauth/access_token')
    values = { :client_id => CLIENT_ID,
               :client_secret => CLIENT_SECRET,
               :code => temporary_code }

    response = Net::HTTP.post_form(uri, values, accept: :json)

    puts response.body

  end

end