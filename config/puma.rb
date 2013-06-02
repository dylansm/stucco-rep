rails_env = ENV['RAILS_ENV'] || 'production'

threads 4,4

if rails_env == "staging"
  bind  "unix:///home/deploy/apps/staging-students.adoberep.com/tmp/puma/staging-students.adoberep.com-puma.sock"
  pidfile "/home/deploy/apps/staging-students.adoberep.com/current/tmp/puma/pid"
  state_path "/home/deploy/apps/staging-students.adoberep.com/current/tmp/puma/state"
else
  bind  "unix:///home/deploy/apps/adoberep.com/tmp/puma/adoberep.com-puma.sock"
  pidfile "/home/deploy/apps/adoberep.com/current/tmp/puma/pid"
  state_path "/home/deploy/apps/adoberep.com/current/tmp/puma/state"
end

activate_control_app
