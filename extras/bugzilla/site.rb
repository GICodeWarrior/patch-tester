module Bugzilla
  class Site
    def initialize(url)
      @url = URI.parse(url)
    end

    def search(params)
      document = make_request('/buglist.cgi', params)

      document.css('.bz_id_column a').map do |anchor|
        Bug.new(self, anchor.text.to_i)
      end
    end

    def make_request(path, params={}, raw=false)
      request_url = @url.clone
      request_url.path = path
      request_url.query = params.map do |key, value|
        "#{Rack::Utils.escape(key)}=#{Rack::Utils.escape(value)}"
      end.join('&')

      curl = Curl::Easy.http_get(request_url.to_s) do |config|
        config.follow_location = true
      end

      if raw
        curl.body_str
      else
        Nokogiri::HTML(curl.body_str)
      end
    end
  end
end
