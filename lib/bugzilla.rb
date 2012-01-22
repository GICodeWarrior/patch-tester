module Bugzilla
end

require 'cgi'
require 'uri'

require 'active_support'
require 'curb'
require 'nokogiri'

require 'bugzilla/attachment'
require 'bugzilla/bug'
require 'bugzilla/patch'
require 'bugzilla/site'
