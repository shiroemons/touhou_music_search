class Odesli
  attr_reader :response, :status, :body

  def initialize(url)
    odesli_url = "https://api.song.link/v1-alpha.1/links?url=#{url}&userCountry=JP"
    @response = Faraday.get(odesli_url)
    @status = @response.status
    @body = JSON.parse(@response.body)
  end

  def amazon_music_title
    entity_unique_id = @body.dig('linksByPlatform', 'amazonMusic', 'entityUniqueId')
    @body.dig('entitiesByUniqueId', entity_unique_id, 'title')
  end

  def amazon_music_url
    @body.dig('linksByPlatform', 'amazonMusic', 'url')&.chomp('?do=play')&.chomp('&do=play')
  end

  def amazon_store_url
    @body.dig('linksByPlatform', 'amazonStore', 'url')
  end
end
