class Record::Match < Record::Base
  def best query_hash = {}, options = { crawl: false, social: false, results: 10 }
    @query_hash = query_hash.delete_if { |_k, v| v.nil? || v.blank? }
    @container = '_all' if @container.nil?
    @options = options
    sanitize_results
  end

  def elasticsearch_results
    Elasticsearch::Model.client.search(index: @container, body: query).deep_symbolize_keys!
  end

  def sanitize_results
    elasticsearch_results[:hits][:hits].map do |result|
      Record::Base.new(result[:_index], result[:_id] + '.json').current_data(@options).merge(container: result[:_index],match_score: result[:_score])
    end
  end

  def query
    @query = {
      query: {
        bool: {
          should: match_query
        }
      },
      size: limit_results
    }
  end

  def match_query
    @query_hash.map do |k, v|
      {
        match: {
          k => v
        }
      }
    end
  end

  def limit_results
    if !@options[:results]
      10
    elsif @options[:results] > 25
      25
    else
      @options[:results]
    end
  end
end
