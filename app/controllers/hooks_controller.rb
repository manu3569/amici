class HooksController < ApplicationController


  get "/about" do
    "This is amici!"
  end

  get_or_post "/" do
    File.open("log/amici.log", 'a') { |file| file.write("Request received at: #{Time.now}: \n" + request.inspect) }
    "Thanks, GitHub! :D"
  end

end