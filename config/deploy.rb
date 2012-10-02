set :default_stage, "production"
require 'capistrano/ext/multistage'
require "bundler/capistrano"
load "deploy/assets"