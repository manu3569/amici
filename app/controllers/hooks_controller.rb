class HooksController < ApplicationController


  get "/about" do
    "This is amici!"
  end

  get_or_post "/" do
    puts ""
    puts ""
    puts "Request received at: #{Time.now}: "
    puts ""
    ap request.inspect
    puts ""
    puts ""
  end

end