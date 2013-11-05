require 'bundler/capistrano' # for bundler support

set :application, "amici" # This should mirror what you put in your NGinx Conf

set :user, 'deploy' # Whatever the User You Make on Your Server

# You should fork this:
# http://github.com/flatiron-school/sinatra-deploy-ruby-003

# You should add your server's SSH Key to your Github Account:
# First generate an SSH Key for your sever. From SSH'ing your server
# Type:
# ssh-keygen -t rsa -b 4096
# Press enter a bunch of times until you are done generating the key.
# Then:
# cat ~/.ssh/id_rsa.pub
# You should get the output of your server's SSH Key.
# Add it to your account: https://github.com/settings/ssh

set :branch, fetch(:branch, "master")

set :repository,  "git@github.com:manu3569/amici.git" # The address of your fork's clone URL

set :deploy_to, "/home/#{ user }/#{ application }"
set :use_sudo, false

set :scm, :git

default_run_options[:pty] = true

set :server_ip, '162.243.77.173' # This should be your server IP
role :web, "#{server_ip}"                          # Your HTTP server, Apache/etc
role :app, "#{server_ip}"                          # This may be the same as your `Web` server
role :db,  "#{server_ip}", :primary => true        # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do

 task :symlink_database, :roles => :app do
  run "ln -nfs #{shared_path}/amici-production.db #{current_path}/db/amici-production.db"
 end

 task :migrate, :roles => :app do
  run "cd #{current_path} && rake db:migrate RACK_ENV=production"
 end

 task :start do ; end
 task :stop do ; end
 task :restart, :roles => :app, :except => { :no_release => true } do
   run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
 end
end