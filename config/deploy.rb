# 変更が必要な内容
set :application, "myporj"
set :repository,  "git@github.com:semind/myproj.git"
set :user, "myproj"
set :use_sudo, false

# それ以外
ssh_options[:paranoid] = false
ssh_options[:auth_methods] = ["publickey"]
ssh_options[:port] = 22

set :scm, :git
set :rails_env,   "production"
set :keep_releases, 2

set :deploy_via, :rsync_with_remote_cache
set :rsync_options, '-az --delete --delete-excluded --exclude=.git'

set :bundle_cmd, "/home/#{user}/.rbenv/shims/bundle"
set :bundle_without, [:development, :test]

set :default_environment, {
  'PATH' => "$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH",
}

after :deploy, "deploy:cleanup"
after "deploy:setup" do
  run <<-CMD
        mkdir -p "#{shared_path}/run"
  CMD
end

namespace :deploy do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_script} start"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{unicorn_script} stop"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{unicorn_script} graceful_stop"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_script} reload"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{unicorn_script} restart"
  end
end
