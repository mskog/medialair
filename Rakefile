require 'rake/remote_task'
require 'yaml'

config = YAML.load_file('deploy.yml')

set :domain, config['domain']+config['directory']

namespace :deploy do
  remote_task :run do
    run "cd #{config['project']} && git pull && touch tmp/restart.txt"
  end

  remote_task :restart do
    run "cd #{config['project']} && touch tmp/restart.txt"
  end

  remote_task :setup do
    run "mkdir #{config['project']}"
    run "cd #{config['project']} && git clone #{config['repository']} ."
  end
end