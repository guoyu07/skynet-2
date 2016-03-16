# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://" + ENV['DOMAIN'] + '/'

SitemapGenerator::Sitemap.sitemaps_path = "#{ENV['CONTAINER']}/"

SitemapGenerator::Sitemap.create_index = true

SitemapGenerator::Sitemap.sitemaps_host = "http://#{ENV['DOMAIN']}/"

SitemapGenerator::Sitemap.adapter = SitemapGenerator::S3Adapter.new(Rails.configuration.config[:fog].merge(fog_directory: "#{ENV['DOMAIN']}-sitemaps",
                                         fog_region: 'us-west-1', fog_provider: 'AWS'))

SitemapGenerator::Sitemap.create do
  # ['boxed-offers'].each do |container|
  begin
    Cloud.new(container).files.each do |file|
      add (container + '/' + file.key.gsub('.json','')), lastmod: file.last_modified
    end if container = ENV['CONTAINER']
  rescue => e
    ap e.message
  end
  # Rails.configuration.config[:admin][:api_containers].reverse.each do |container|
  #   begin
  #     Cloud.new(container).files.each do |file|
  #       add (container + '/' + file.key.gsub('.json','')), lastmod: file.last_modified
  #     end
  #   rescue => e
  #     ap e.message
  #   end
  # end
end
