app_name = 'crm'

set :repo_url, "git@github.com:digitalshop24/#{app_name}.git"
set :application, app_name
application = app_name
set :rvm_type, :user
set :rvm_ruby_version, '2.2.1'
set :deploy_to, "/var/www/apps/#{app_name}"

set :faye_pid, "#{deploy_to}/run/faye.pid"
set :faye_config, "#{deploy_to}/current/faye.ru"

lock '3.4.0'

namespace :server do
  rails_env = 'production'
  desc 'Start server'
  task :start do
    on roles(:all) do
      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec unicorn_rails -c #{current_path}/config/unicorn.rb -E #{rails_env}"
      end
    end
  end

  desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done."
  task :restart do
    on roles(:all) do
      execute "kill -USR2 $(cat /var/www/apps/#{app_name}/run/unicorn.pid)"
    end
  end

  desc "Stop the application by killing the Unicorn process"
  task :stop do
    on roles(:all) do
      execute "kill $(cat #{deploy_to}/run/unicorn.pid)"
    end
  end
end

namespace :deploy do
  desc 'Upload config files'
  task :upload do
    on roles(:all) do
      upload!('config/application.yml', "#{shared_path}/config/application.yml")
    end
  end

  desc 'Setup'
  task :setup do
    on roles(:all) do
      execute "mkdir  #{shared_path}/config/"
      execute "mkdir  /var/www/apps/#{application}/run/"
      execute "mkdir  /var/www/apps/#{application}/log/"
      execute "mkdir  /var/www/apps/#{application}/socket/"
      execute "mkdir #{shared_path}/system"

      upload!('config/application.yml', "#{shared_path}/config/application.yml")

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end
    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      execute "ln -s #{shared_path}/system #{release_path}/public/system"
      execute "ln -s #{shared_path}/config/application.yml #{release_path}/config/application.yml"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'

  after :updating, 'deploy:symlink'

  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'
end

namespace :git do
  desc 'Deploy'
  task :deploy do
    ask(:message, "Commit message?")
    run_locally do
      execute "git add -A"
      execute "git commit -m '#{fetch(:message)}'"
      execute "git push -u origin master"
    end
  end
end
after 'git:deploy', 'deploy'
after :deploy, 'server:restart'

namespace :faye do
  desc "Start Faye"
  task :start do
    on roles(:all) do
      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec rackup #{current_path}/faye.ru -s thin -E production -D --pid #{deploy_to}/run/faye.pid"
      end
    end
  end
  desc "Stop Faye"
  task :stop do
    on roles(:all) do
      execute "kill `cat #{faye_pid}` || true"
    end
  end
end

namespace :sidekiq do
  desc "Start Sidekiq"
  task :start do
    on roles(:all) do
      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec sidekiq -c 10 -e production -d -L /var/www/apps/crm/log/sidekiq.log -P /var/www/apps/crm/run/sidekiq.pid"
      end
    end
  end
  desc "Stop Sidekiq"
  task :stop do
    on roles(:all) do
      execute "kill `cat #{deploy_to}/run/sidekiq.pid` || true"
    end
  end
end
