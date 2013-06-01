server '216.223.21.209', :app, :web, :db, :primary => true

set :domain, "#{application}"
set :deploy_to, "/home/deploy/apps/#{domain}"
set :deploy_env, 'production'
set :rails_env, 'production'
