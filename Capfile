# 複数のデプロイ環境の作成をサポート
require "capistrano/ext/multistage"
# デプロイ時にbundle install実行する
require 'bundler/capistrano'

load 'deploy' if respond_to?(:namespace)
load 'config/deploy'
