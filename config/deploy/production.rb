set :application, "aaweb"
set :domain, "75.147.182.89"
set :repository,  "git@github.com:dawnfriedland/aaweb.git"
set :use_sudo,    false
set :deploy_to, "/home/www-publisher/www/aaweb"
set :scm,         "git"
set :user,        "www-publisher"

role :app, domain
role :web, domain
role :db,  domain, :primary => true

require "rvm/capistrano"                  # Load RVM's capistrano plugin.
set :rvm_type, :system
set :rvm_ruby_string, '1.9.3@aaweb'        # Or whatever env you want it to run in.

namespace :rvm do
  task :trust_rvmrc do
    run "rvm rvmrc trust #{current_release}"
  end
end

namespace :db do
  task :cp_db_config, :roles => :app do
    run "cp /home/www-publisher/aaweb/config/database.yml #{current_release}/config/"
  end
end

namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_release}/tmp/restart.txt"
  end
end

before "deploy:assets:precompile", "db:cp_db_config"
after "deploy", "rvm:trust_rvmrc"

