require './config/environment.rb'

log = File.new("log/amici.log", "a")
STDOUT.reopen(log)
STDERR.reopen(log)

use HooksController
run ApplicationController