set :application, "www"
set :repository,  "ssh://git@git.lab.mabarroso.com/tdmnotice.git"
set :scm, :git
set :branch, "master"
set :user, "web"
default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :use_sudo, false
#ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa")]

# Multistage
set :stages, %w(production beta)
require 'capistrano/ext/multistage'

# RVM Setup
require "rvm/capistrano"
require "bundler/capistrano"
set :rvm_type, :user
#set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"")
set :rvm_ruby_string,'ruby-1.9.3-p194'
set :bundle_without, [:development]

def set_deploy stage_path
  set :deploy_to, "/www/deploy/#{stage_path}/tdmnotice/#{application}"
  set :deployed_path, "/www/#{stage_path}/site/tdmnotice/#{application}/rails/#{application}/current"
  set :rails_env, stage_path
end

set :keep_releases, 5
after "deploy:update", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  desc "reload the database with seed data"
  task :seed do
#    run "cd #{current_path}; bundle exec rake db:seed RAILS_ENV=#{rails_env}"
  end
  desc "Recreate symlink"
  task :resymlink, :roles => :app do
    run "rm -f #{deployed_path} && ln -nfs #{release_path} #{deployed_path}"
  end
end
namespace :assets do
  task :precompile, :roles => :web, :except => { :no_release => true } do
  	run "cd #{latest_release}; bundle exec rake assets:precompile RAILS_ENV=#{rails_env}"
  end
end

namespace :rvm do
  task :trust_rvmrc do
    #run "rvm rvmrc trust #{release_path}"
  end
end

after "deploy", "deploy:migrate", "deploy:resymlink", "deploy:restart"
