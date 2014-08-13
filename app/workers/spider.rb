class Spider < Worker
  sidekiq_options backtrace: true, unique: :all, expiration: 24 * 60 * 60

  def perform url, params = nil, headers = ''
  	@url = url
    get_page params, headers
    visit
  end

  def get_page params = nil, headers = ''
    parser.page = params ? scraper.post(params, headers) : scraper.get
  end

  def scraper
  	@scraper ||= Scrape.new(@url)
  end

  def parser
  	@parser ||= Parse.new(@url)
  end

  def visit
    @visit ||= Visit.new(parser.internal_links)
  end
end