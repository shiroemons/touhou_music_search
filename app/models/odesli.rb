class Odesli
  def self.fetch(url)
    odesli_url = "https://api.song.link/v1-alpha.1/links?url=#{url}&userCountry=JP"
    Faraday.get(odesli_url)
  end
end
