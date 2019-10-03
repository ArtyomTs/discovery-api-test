require './secret'
require 'open-uri'
require 'json'

class DiscoveryAPIAdapter

  def initialize(country, data_format)
    @country = country
    @format = data_format
  end

  def fetch_discovery_feed
    puts 'Downloading...'
    download_data_file
  end

  private

  def download_data_file
    data_uri = get_data_uri
    puts data_uri
    open(data_uri).read
  end

  def get_data_uri
    country_summary = summary.dig('countries', @country)
    raise "No such country" if country_summary.nil?
    country_summary.dig(@format.upcase, 'uri')
  end

  def summary
    JSON.parse get_response
  end

  def get_response
    source = URI.parse uri
    source.read
  end

  def uri
    "https://app.ticketmaster.com/discovery-feed/v2/events?apikey=#{API_TOKEN}"
  end
end
