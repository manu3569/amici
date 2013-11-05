require './config/environment.rb'

use AuthorizationController
use HooksController
run ApplicationController