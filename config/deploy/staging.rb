server '216.223.21.209', :app, :web, :db, :primary => true

set :domain, "staging-students.#{application}"
set :deploy_to, "/home/deploy/apps/#{domain}"
set :deploy_env, 'staging'
set :rails_env, 'staging'

namespace :deploy do

  desc "Restart application"
  task :restart, :roles => :app do
    #run "cd #{current_path}; bundle exec pumactl -S #{current_path}/tmp/puma/state/#{deploy_env}.state restart"
    run "kill -USR2 `ps aux | grep /home/deploy/apps/staging-students.adoberep.com/shared/bundle/ruby/2.0.0/bin/puma | grep -v grep | awk '{print $2}'`"
  end

  desc "Stop application"
  task :stop, :roles => :app do
    run "kill -9 `ps aux | grep /home/deploy/apps/staging-students.adoberep.com/shared/bundle/ruby/2.0.0/bin/puma | grep -v grep | awk '{print $2}'`"
  end

end
