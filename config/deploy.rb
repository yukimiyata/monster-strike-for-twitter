lock "~> 3.9.0"

set :application, "monster-strike-for-twitter"
set :repo_url, "git@github.com:yukimiyata/monster-strike-for-twitter.git"
set :user, 'miyata'
set :deploy_to, "/var/www/monster-strike-for-twitter"
set :linked_files, %w[config/master.key config/database.yml]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets public/system vendor/bundle]
set :rbenv_ruby, File.read('.ruby-version').strip
set :puma_threds, [4, 16]
set :puma_workers, 0
set :puma_bind, "unix://#{shared_path}/tmp/sockets/puma.sock"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log, "#{shared_path}/log/puma.access.log"
set :puma_preload_app, true
set :bundle_flags,      '--quiet' # this unsets --deployment, see details in config_bundler task details
set :bundle_path,       nil
set :bundle_without,    nil
# set :bundle_gemfile, "server/Gemfile"

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'Config bundler'
  task :config_bundler do
    on roles(/.*/) do
      within release_path do
        execute :bundle, :config, '--local deployment true'
        execute :bundle, :config, '--local without "development test"'
        execute :bundle, :config, "--local path #{shared_path.join('bundle')}"
      end
    end
  end

  desc 'upload important files'
  task :upload do
    on roles(:app) do
      sudo :mkdir, '-p', "#{shared_path}/config"
      sudo %[chown -R #{fetch(:user)}.#{fetch(:user)} /var/www/#{fetch(:application)}]
      sudo :mkdir, '-p', '/etc/nginx/sites-enabled'
      sudo :mkdir, '-p', '/etc/nginx/sites-available'

      upload!('config/database.yml', "#{shared_path}/config/database.yml")
      upload!('config/master.key', "#{shared_path}/config/master.key")
    end
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:migrate'
        end
      end
    end
  end

  before :starting, :upload
  before 'check:linked_files', 'puma:nginx_config'
end

after 'deploy:published', 'nginx:restart'
before 'deploy:migrate', 'deploy:db_create'
before 'bundler:install', 'deploy:config_bundler'