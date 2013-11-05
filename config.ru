require './config/environment.rb'

use UsersController
use AuthorizationController
use HooksController
run ApplicationController