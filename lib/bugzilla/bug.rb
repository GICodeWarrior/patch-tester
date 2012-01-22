module Bugzilla
  class Bug
    attr_reader :id

    def initialize(site, id)
      @site = site
      @id = id
    end

    def active_patches
      document = @site.make_request('/attachment.cgi', :action => 'viewall',
                                                       :bugid => @id)

      frames = document.css('.attachment_info + iframe').select do |frame|
        type = frame.previous.at_css('tr:nth-child(2) td:nth-child(2)').text

        type.strip == 'patch' && !frame.previous.at_css('.bz_obsolete')
      end

      frames.map do |frame|
        Patch.new(@site, frame['src'].sub(/^.*\?id=/, '').to_i)
      end
    end
  end
end
