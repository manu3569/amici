require 'bundler'
require 'json'
require 'net/http'

Bundler.require(:default, ENV['RACK_ENV'])

ENV['RACK_ENV'] ||= 'development'

CLIENT_ID = ENV['GH_BASIC_CLIENT_ID']
CLIENT_SECRET = ENV['GH_BASIC_SECRET_ID']

DB = Sequel.connect("sqlite://db/amici-#{ENV['RACK_ENV']}.db")


def load_dirs(array)
  array.each do |dir|
    Dir.entries(dir).each do |file|
      next if file.start_with?(".") || file == 'application_controller.rb'
      require_relative "../#{dir}/#{file}"
    end
  end
end

require_relative '../app/controllers/application_controller.rb'

load_dirs(['app/models', 'app/controllers'])
