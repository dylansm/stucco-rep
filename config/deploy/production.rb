server '216.223.21.209', :app, :web, :db, :primary => true

set :domain, "#{application}"
set :deploy_to, "/home/deploy/apps/#{domain}"
set :deploy_env, 'production'
set :rails_env, 'production'

namespace :deploy do

  desc "Restart application"
  task :restart, :roles => :app do
    #run "cd #{current_path}; bundle exec pumactl -S #{current_path}/tmp/puma/state/#{deploy_env}.state restart"
    run "kill -USR2 `ps aux | grep /home/deploy/apps/adoberep.com/shared/bundle/ruby/2.0.0/bin/puma | grep -v grep | awk '{print $2}'`"
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "kill -9 `ps aux | grep /home/deploy/apps/adoberep.com/shared/bundle/ruby/2.0.0/bin/puma | grep -v grep | awk '{print $2}'`"
    run "rm /home/deploy/production/tmp/puma/socket/production-puma.sock"
  end

end
