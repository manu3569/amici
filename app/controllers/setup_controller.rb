class SetupController < ApplicationController

  get "/" do
    unless Setup.done?
      redirect "/setup"
    end
    "You're all set to go :("
  end

  get "/setup" do
    @setup = Setup.new
    erb :"setup/form"
  end

end