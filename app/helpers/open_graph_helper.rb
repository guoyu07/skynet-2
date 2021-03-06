module OpenGraphHelper
  def build_open_graph
    @open_graph = false
    methods.grep(/og/).each do |og|
      send(og)
    end
    @open_graph = true if @type
    # @id = @name.tr(" ", "_") if @type
  end

  ###############################################################
  # og:type - The type of your object, e.g., "video.movie".
  # Depending on the type you specify, other properties may also
  # be required.
  ###############################################################

  def og_type
    @type = meta_property('og:type').downcase.capitalize unless @type rescue nil
  end

  ###############################################################
  # og:title - The title of your object as it should appear
  # within the graph, e.g., "The Rock".
  ###############################################################

  def og_name
    @name = meta_name 'twitter:title' unless @name rescue nil
    @name = meta_property 'og:title' unless @name rescue nil
  end

  ###############################################################
  # og:description - A one to two sentence description of your
  # object.
  ###############################################################

  def og_description
    @description = meta_name 'twitter:description' unless @description rescue nil
    @description = meta_property 'og:description' unless @description rescue nil
  end

  ###############################################################
  # og:url - The canonical URL of your object that will be used
  # as its permanent ID in the graph, e.g.,
  # "http://www.imdb.com/title/tt0117500/"
  ###############################################################

  def og_url
    @url = meta_name 'twitter:url' unless @url rescue nil
    @url = meta_property 'og:url' unless @url rescue nil
    @id = Digest::MD5.hexdigest(@url) if @url
  end

  ###############################################################
  # og:image - An image URL which should represent your object
  # within the graph.
  ###############################################################

  def og_image
    @image = meta_name 'twitter:image' unless @image rescue nil
    @image = meta_property 'og:image' unless @image rescue nil
  end

  ###############################################################
  # og:audio - A URL to an audio file to accompany this object.
  ###############################################################

  def og_audio
    @audio = meta_property 'og:audio' unless @audio rescue nil
  end

  ###############################################################
  # og:determiner - The word that appears before this object's
  # title in a sentence. An enum of (a, an, the, "", auto). If
  # auto is chosen, the consumer of your data should chose
  # between "a" or "an". Default is "" (blank).
  ###############################################################

  def og_determiner
    @determiner = meta_property 'og:determiner' unless @determiner rescue nil
  end

  ###############################################################
  # og:locale - The locale these tags are marked up in. Of the
  # format language_TERRITORY. Default is en_US.
  ###############################################################

  def og_locale
    @locale = meta_property 'og:locale' unless @locale rescue nil
  end

  ###############################################################
  # og:locale:alternate - An array of other locales this page is
  # available in.
  ###############################################################

  def og_locale_alternate
    @locale_alternate = meta_property 'og:locale:alternate' unless @locale_alternate rescue nil
  end

  ###############################################################
  # og:site_name - If your object is part of a larger web site,
  # the name which should be displayed for the overall site.
  # e.g., "IMDb".
  ###############################################################

  def og_site_name
    @site_name = meta_property('og:site_name').capitalize unless @site_name rescue nil
  end

  ###############################################################
  # og:video - A URL to a video file that complements this object
  ###############################################################

  def og_video
    @video = meta_property 'og:video' unless @video rescue nil
  end

  ###############################################################
  # og:upc - A UPC or Universal Product Code
  ###############################################################

  def og_upc
    @upc = parser.css('meta[@property="og:upc"]').first['content'].try(:squish) unless @upc rescue nil
  end

  def meta_property(metadata)
    property = parser.css("meta[@property='#{metadata}']").first['content'].try(:squish)
    # if !property.nil? then @open_graph = true; return property end
  end

  def meta_name(metadata)
    name = parser.css("meta[@name='#{metadata}']").first['content'].try(:squish)
    # if !name.nil? then @open_graph = true; return name end
  end
end
