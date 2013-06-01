# -*- coding: utf-8 -*-
set :user, "name"
set :ssh_options, :port=>22, :forward_agent=>false, :keys=>"path"
set :use_sudo, false
set :normalize_asset_timestamps, false
set :keep_releases, 3

set :application, "MyApps"
set :deploy_via, :rsync_with_remote_cache
set :scm ,:git
#set :repository,  "git@myrepo"
set :repository, "."
set :branch, :master
set :deploy_to,    "/var/www/Myapps"
set :copy_exclude, %w(
    Capfile
)
set :rsync_options, '-az --delete --exclude=PATTERN --exclude=.git --exclude=' + copy_exclude.join(' --exclude=')
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

#role :web, "your web-server here"                          # Your HTTP server, Apache/etc

set :deployTargets,  "127.0.0.1"

role :web, deployTargets
#role :app, "your app-server here"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end

# lsコマンド実行タスク
task :list  do
    run "ls"
end

after "deploy", "change_permission"

desc "Change tmp prmission to 777"
task :change_permission, roles => :web do
  run <<-CMD
    chmod -R 777 #{deploy_to}current/tmp
  CMD
end