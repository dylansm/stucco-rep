server '216.223.21.209', :app, :web, :db, :primary => true

set :domain, "staging-students.#{application}"
set :deploy_to, "/home/deploy/apps/#{domain}"
set :deploy_env, 'staging'
set :rails_env, 'staging'
