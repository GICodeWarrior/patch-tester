module Bugzilla
  class Attachment
    extend ActiveSupport::Memoizable

    def initialize(site, id)
      @site = site
      @id = id
    end

    def contents
      @site.make_request('/attachment.cgi', {:id => @id}, true)
    end
    memoize :contents
  end
end
