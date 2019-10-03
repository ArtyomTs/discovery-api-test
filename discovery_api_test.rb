require 'rubygems'
require 'bundler'

Bundler.require(:default)

require './discovery_api_adapter'
require './file_data_storage'
require './csv_processor'
require './statistics'

class DiscoveryAPITest
  def self.run
    puts 'Discovery API test.'
    # begin
      data = FileDataStorage.new('US', 'csv').read
      statistics = Statistics.new
      CSVProcessor.fetch(data) do |row|
        statistics.update_with row
      end

      puts ?-*20
      puts statistics
    # rescue Exception => e
    #   puts e.message
    # end
  end
end

DiscoveryAPITest.run
