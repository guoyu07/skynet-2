chruby 2.3.0 && git checkout . && git pull origin master && rm .ruby-version && cd app/sites && git pull origin master && cd ../.. && cp config/sidekiq.yml.example config/sidekiq.yml && bundle && RAILS_ENV=production bundle exec sidekiq -d -L log/sidekiq.log
