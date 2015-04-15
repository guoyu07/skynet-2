class Crawler::ScrimperAlternate < Crawler::Base
  sidekiq_options queue: :scrimper_alternate,
                  retry: true,
                  backtrace: true,
                  unique: true,
                  unique_job_expiration: 24 * 60

  def perform(url)
    @url = url
    parser.page = scraper.get
    upload
  rescue Net::HTTP::Persistent::Error => e
    Crawler::ScrimperAlternate.perform_async @url
  rescue Mechanize::RedirectLimitReachedError => e
    nil
  end
end
