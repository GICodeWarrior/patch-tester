module Bugzilla
  class Attachment
    def initialize(site, id)
      @site = site
      @id = id
    end

    def contents
      @contents ||= @site.make_request('/attachment.cgi', {:id => @id}, true)
    end
  end
end
