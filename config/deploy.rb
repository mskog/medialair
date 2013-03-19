require "rvm/capistrano"
require "bundler/capistrano"
require 'yaml'

config = YAML.load_file('deploy.yml')

set :domain, config['domain']
set :application, config['project']
set :deploy_to, "#{config['directory']}/#{application}"

set :user, config['user']
set :use_sudo, false
 
set :scm, :git
set :repository,  config['repository']
set :branch, config['branch']
set :git_shallow_clone, 1
 
role :web, domain
role :app, domain
role :db,  domain, :primary => true
 
set :deploy_via, :remote_cache
 
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/configuration.yml #{release_path}/configuration.yml"
  end
end

after "deploy:finalize_update", "deploy:symlink_config"
