require 'net/http'
require 'net/https'
require 'uri'
require 'json'

uri = URI("https://api.github.com/repos/manu3569/pollywog-ranch-rails-ruby-003/hooks")

header = {"Content-Type" => "application/json", "Authorization" => "token 5fccefe0e2a3944bfd65b030eb2140de3338f3fd"}
body   = '{"name": "web", "active": true, "events": ["push", "fork"], "config": {"url": "http://162.243.77.173/", "content_type": "json"}}'

id = nil

# Create Hook
Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  request = Net::HTTP::Post.new(uri, header)
  request.body = body
  response = http.request(request)  
  puts JSON.parse(response.body)
end

# List Hooks
Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  request = Net::HTTP::Get.new(uri, header)
  response = http.request(request)  
  json = JSON.parse(response.body)
  puts json
  id = json.first["id"]
end

uri = URI("https://api.github.com/repos/manu3569/pollywog-ranch-rails-ruby-003/hooks/#{id}")

# Delete Hook
Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  request = Net::HTTP::Delete.new(uri, header)
  response = http.request(request)  
  puts response.body.inspect
end

uri = URI("https://api.github.com/repos/manu3569/pollywog-ranch-rails-ruby-003/hooks")
# List Hooks
Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
  request = Net::HTTP::Get.new(uri, header)
  response = http.request(request)  
  puts response.body.inspect
        end
