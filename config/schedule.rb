# frozen_string_literal: true

# Rails.rootを使用するために必要
require File.expand_path("#{File.dirname(__FILE__)}/environment")

# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
set :environment, rails_env

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

set :job_template, "/bin/zsh -l -c ':job'"

job_type :rake,
         'export PATH="$HOME/.rbenv/bin:$PATH"; eval "$(rbenv init -)"; cd :path && RAILS_ENV=:environment bundle exec rake :task :output'

# 定期実行したい処理を記入
every 1.day, at: '9:00 am' do
  rake 'rank:rank_day'
end

every :monday, at: '9:00 am' do
  rake 'rank:rank_week'
end

every '0 9 1 * *' do
  rake 'rank:rank_month'
end

every 1.day, at: '9:00 am' do
  rake 'rank:delete_notifications'
end
