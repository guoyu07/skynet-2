class Crawler::ScraperTen < Crawler::Scraper
  sidekiq_options queue: :scraper_ten,
                  retry: true,
                  backtrace: true,
                  unique: :until_and_while_executing,
                  unique_expiration: 120 * 60

  def next_type
    @type ||= 'ScrimperTen'
  end

  def paginate
    parser.paginate.each do |next_url|
      Crawler::ScraperTen.perform_async next_url
    end
  end
end
