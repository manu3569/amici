require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'])

require 'json'
require 'net/http'
require 'net/https'
require 'uri'
require 'open-uri'

ENV['RACK_ENV'] ||= 'development'

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
