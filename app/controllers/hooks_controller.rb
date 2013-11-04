class HooksController < ApplicationController

  get_or_post "/" do
    puts ""
    puts ""
    puts "Request received at: #{Time.now}: "
    puts ""
    puts params.inspect
    puts ""
    puts ""
  end

end