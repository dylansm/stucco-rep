server '216.223.21.209', :app, :web, :db, :primary => true

set :domain, "staging-students.#{application}"
set :deploy_to, "/home/deploy/apps/#{domain}"
set :deploy_env, 'staging'
set :rails_env, 'staging'

#namespace :deploy do
  #desc "Start application"
  #task :start, :roles => :app do
    #run "cd #{current_path}; RAILS_ENV=#{deploy_env} bundle exec puma -d -e production -S #{current_path}/tmp/puma/state/staging.state -b unix://#{current_path}/tmp/puma/socket/staging-puma.sock"
  #end

  #desc "Restart application"
  #task :restart, :roles => :app do
    #run "cd #{current_path}; bundle exec pumactl -S #{current_path}/tmp/puma/state/#{deploy_env}.state restart"
  #end

  #desc "Stop application"
  #task :stop, :roles => :app do
    #run "cd #{current_path}; bundle exec pumactl -S #{current_path}/tmp/puma/state/#{deploy_env}.state stop"
  #end
#end
