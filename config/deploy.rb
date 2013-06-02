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

end

namespace :puma do
  desc "create a shared tmp dir for puma state files"
  task :after_symlink, roles: :app do
    run "sudo rm -rf #{release_path}/tmp"
    run "ln -s #{shared_path}/../tmp #{release_path}/tmp"
  end
  after "deploy:create_symlink", "puma:after_symlink"
end

after 'deploy:setup', 'deploy:upload_settings', 'deploy:create_sockets_directory'
before 'deploy:assets:precompile', 'deploy:symlink_db', 'deploy:symlink_api_keys'
