env_apps_map = {
  staging: 'staging-students.adoberep.com',
  production: 'adoberep.com'
}
app_name = env_apps_map[ENV['RAILS_ENV'].to_sym]

threads 4,4

bind  "unix:///home/deploy/apps/#{app_name}/tmp/puma/#{app_name}-puma.sock"
pidfile "/home/deploy/apps/#{app_name}/current/tmp/puma/pid"
state_path "/home/deploy/apps/#{app_name}/current/tmp/puma/state"

activate_control_app
