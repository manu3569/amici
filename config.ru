require './config/environment.rb'

log = Logger.new('log/amici.log')
STDOUT.reopen(log)
STDERR.reopen(log)

use HooksController
run ApplicationController