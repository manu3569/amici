class SetupController < ApplicationController

  get "/" do
    unless Setup.done?
      redirect "/setup"
    end
    "You're all set to go :("
  end

  #redirect_uri
  get "/setup/callback" do
      
  end

  get "/setup" do
    @setup = Setup[1] || Setup.new
    if @setup.client_id.nil? || @setup.client_secret.nil?
      erb :"setup/get_id_and_secret"
    elsif @setup.token.nil?
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