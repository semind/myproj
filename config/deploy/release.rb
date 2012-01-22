# デプロイ時にrake assets:precompileが走る
load 'deploy/assets'

# ホスト名は変更が必要
server 'release', :app, :web, :db, :primary => true

set :branch,    "master"
set :deploy_to, "/home/#{user}/release"

set :unicorn_script, "/home/#{user}/release/current/script/unicorn/release"
set :unicorn_conf,   "/home/#{user}/release/current/config/unicorn/release.rb"
set :unicorn_pid,    "/home/#{user}/release/current/tmp/pids/release.pid"

