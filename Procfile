web: bundle exec puma -C config/puma.rb
release: heroku run rails db:migrate & rails db:seed
worker: bundle exec sidekiq -c 2