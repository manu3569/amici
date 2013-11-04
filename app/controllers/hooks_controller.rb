class HooksController < ApplicationController


  get "/about" do
    "This is amici!"
  end

  get_or_post "/" do
    File.open("log/amici.log", 'a') { |file| file.write("Request received at: #{Time.now}: \n" + request.inspect + "\n" + params.inspect) }
    "Thanks, GitHub! :D"

    # erb :index, :locals => {:client_id => CLIENT_ID}
  end

end