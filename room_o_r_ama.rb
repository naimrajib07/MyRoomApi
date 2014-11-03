require 'json'
require 'net/https'
require 'uri'
require_relative 'json_utilities'
require_relative 'fetcher'
require_relative 'test_data'

module RoomORama
  require_relative 'fetcher'
  class Room
    include JsonUtilities

    attr_accessor :properties, :mapping_hash, :url, :header

    def initialize(json_str, mapping_hash, url, header)
      @properties  = JSON.parse(Fetcher.get_properties(json_str))
      @mapping_hash = mapping_hash
      @url = url
      @header = header
    end

    def reform_hash
      self.make_hash
    end

    def fetch
      uri = URI.parse(self.url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data(self.reform_hash)
      request.add_field('Authorization', self.header['Authorization'])

      response = http.request(request)
      response.body
    rescue Exception => e
      puts e.backtrace.inspect
    end
  end
end