task :environment do |cmd, args|
  ENV["RACK_ENV"] ||= "development"
  require "./config/environment"
end

desc 'Load a pry console'
task :console => [:environment] do
  Pry.start
end


namespace :db do
  desc "Run database migrations"
  task :migrate => [:environment] do |cmd, args|
    env = ENV['RACK_ENV'] || "development"
 
    require 'sequel/extensions/migration'
    Sequel::Migrator.apply(DB, "db/migrations")
  end
 
  desc "Rollback the database"
  task :rollback => [:environment] do |cmd, args|
    env = ENV['RACK_ENV'] || "development"
 
    require 'sequel/extensions/migration'
    version = (row = DB[:schema_info].first) ? row[:version] : nil
    Sequel::Migrator.apply(DB, "db/migrations", version - 1)
  end
 
  desc "Nuke the database (drop all tables)"
  task :nuke => [:environment] do |cmd, args|
    env = ENV['RACK_ENV'] || "development"

    DB.tables.each do |table|
    end
  end
 
  desc "Reset the database"
  task :reset => [:nuke, :migrate]
end