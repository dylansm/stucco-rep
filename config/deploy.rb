require 'rvm/capistrano'                  # Load RVM's capistrano plugin.
require 'capistrano/ext/multistage'
require 'bundler/capistrano'
require 'puma/capistrano'

set :stages, %w(production staging)
set :default_stage, "staging"

set :user, "deploy"
set :ssh_options, { :forward_agent => true }
set :rvm_type, :user
set :application, "adoberep.com"
set :scm, :git
set :branch, "master"
set :repository,  "git@github.com:dylansm/adoberep.git"
set :use_sudo, false
set :runner, user
set :normalize_asset_timestamps, false

namespace :deploy do

  desc "Set up shared/config directory and upload settings files."
  task :upload_settings, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    top.upload("config/database.yml.template", "#{shared_path}/config", :via => :scp)
    top.upload("config/api_keys.yml.template", "#{shared_path}/config", :via => :scp)
  end
  
  task :start, :roles => :app do
    #run "touch #{current_release}/tmp/restart.txt"
    #run "bundle exec pumactl -S /var/run/#{my_app}.state start"
    #
    run "bundle exec cap puma:start"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    #run "touch #{current_release}/tmp/restart.txt"
    #run "bundle exec pumactl -S /var/run/#{my_app}.state restart"
  end

  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml.template #{release_path}/config/database.yml"
  end

  desc "Symlinks the api_keys.yml"
  task :symlink_api_keys, :roles => :app do
    run "ln -nfs #{shared_path}/config/api_keys.yml.template #{release_path}/config/api_keys.yml"
  end

  #desc "Symlinks the .rvmrc"
  #task :symlink_rvmrc, :roles => :app do
    #run "ln -nfs #{deploy_to}/shared/rvmrc #{release_path}/.rvmrc"
  #end

end

#namespace :rvm do
  #desc 'Trust rvmrc file'
  #task :trust_rvmrc do
    #run "rvm rvmrc trust #{current_release}"
  #end
#end

after 'deploy:setup', 'deploy:upload_settings'
before 'deploy:assets:precompile', 'deploy:symlink_db', 'deploy:symlink_api_keys'
#after 'deploy:update_code', 'deploy:symlink_rvmrc'
#after "deploy:update_code", "rvm:trust_rvmrc"
