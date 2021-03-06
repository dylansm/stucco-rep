require 'rvm/capistrano'                  # Load RVM's capistrano plugin.
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

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
set :keep_releases, 3

namespace :deploy do

  desc "Set up shared/config directory and upload settings files."
  task :upload_settings, :roles => :app do
    run "mkdir -p #{shared_path}/config"
    top.upload("config/database.yml.template", "#{shared_path}/config", :via => :scp)
    top.upload("config/api_keys.yml.template", "#{shared_path}/config", :via => :scp)
  end
  
  desc "Symlinks the database.yml"
  task :symlink_db, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml.template #{release_path}/config/database.yml"
  end

  desc "Symlinks the api_keys.yml"
  task :symlink_api_keys, :roles => :app do
    run "ln -nfs #{shared_path}/config/api_keys.yml.template #{release_path}/config/api_keys.yml"
  end

  desc "Write environment to flat file"
  task :write_environment_file, :roles => :app do
    run "if [ -e #{current_path}/config/rails_env_production ]; then rm #{current_path}/config/rails_env_production; fi"
    run "if [ -e #{current_path}/config/rails_env_staging ]; then rm #{current_path}/config/rails_env_staging; fi"
    run "touch #{current_path}/config/rails_env_#{deploy_env}"
  end

  desc "Start application"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{deploy_env} bundle exec puma -C config/puma.rb"
  end

end

namespace :puma do

  desc "Create puma state directories"
  task :setup do
    run "mkdir -p #{shared_path}/../tmp/puma/pid"
    run "mkdir -p #{shared_path}/../tmp/puma/socket"
    run "mkdir -p #{shared_path}/../tmp/puma/state"
  end

  desc "Create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/../tmp #{release_path}/tmp"
  end
  after "deploy:create_symlink", "puma:after_symlink"
end

after 'deploy:setup', 'deploy:upload_settings', 'puma:setup'
before 'deploy:assets:precompile', 'deploy:symlink_db', 'deploy:symlink_api_keys'
after 'deploy:create_symlink', "deploy:write_environment_file"
