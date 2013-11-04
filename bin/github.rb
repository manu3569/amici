require 'faraday'
require 'net/http'

# uri = URI('https://api.github.com/repos/loganhasson/pollywog-ranch-rails-ruby-003/hooks')
# request = Net::HTTP::Post.new(uri)

# strash = '{"name": "web", "active": true, "events": ["push", "fork"], "config": {"url": "http://162.243.77.173/", "content_type": "json"}}'

# request.set_form_data(strash)

# request["Authorization"] = "token c8893b4ef96cf423f3fe52d01c8f312beb76230e"
# request["Content-Type"]  = "application/json"

# result = Net::HTTP.start(uri.hostname, uri.port) do |http|
#   http.request(request)
# end

# case result
# when Net::HTTPSuccess, Net::HTTPRedirection
#   puts result.inspect
#   puts 
# else
#   result.value
# end

###########

conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
  faraday.request  :url_encoded             # form-encode POST params
  faraday.response :logger                  # log requests to STDOUT
  faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
end

path = '/repos/loganhasson/pollywog-ranch-rails-ruby-003/hooks'
strash = '{"name": "web", "active": true, "events": ["push", "fork"], "config": {"url": "http://162.243.77.173/", "content_type": "json"}}'

response = conn.post do |req|
  req.url path
  req.headers['Authorization'] = 'token c8893b4ef96cf423f3fe52d01c8f312beb76230e'
  req.headers['Content-Type'] = 'application/json'
  req.body = strash
end

