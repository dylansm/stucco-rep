env_apps_map = {
  staging: 'staging-students.adoberep.com',
  production: 'adoberep.com'
}
env = ENV['RAILS_ENV']
app_name = env_apps_map[env.to_sym]

threads 4,4

bind  "unix:///home/deploy/apps/#{app_name}/current/puma/#{app_name}-puma.sock"
pidfile "/home/deploy/apps/#{app_name}/current/tmp/puma/pid/#{env}.pid"
state_path "/home/deploy/apps/#{app_name}/current/tmp/puma/state/#{env}.state"

activate_control_app
