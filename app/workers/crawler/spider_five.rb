class Crawler::SpiderFive < Crawler::Spider
  sidekiq_options queue: :spider_five,
                  retry: true,
                  backtrace: true,
                  unique: :until_and_while_executing,
                  unique_expiration: 120 * 60 * 365

  def next_type
    @type ||= 'SpiderFive'
  end
end
