class Crawler::SpiderEight < Crawler::Spider
  sidekiq_options queue: :spider_eight,
                  retry: true,
                  backtrace: true,
                  unique: :until_and_while_executing,
                  unique_expiration: 120 * 60 * 365

  def next_type
    @type ||= 'SpiderEight'
  end
end
