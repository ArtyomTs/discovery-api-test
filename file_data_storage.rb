require './data_storage'
require 'rubygems/package'
require 'zlib'

class FileDataStorage < DataStorage

  private

  def file_name
    "./data/#{@country}_data.#{@format}.gz"
  end

  def unpacked_file_name
    "./data/#{@country}_data.#{@format}"
  end

  def load_data
    open(file_name, 'wb') do |file|
      file << DiscoveryAPIAdapter.new('US', @format).fetch_discovery_feed
    end unless file_exists?
  end

  def data_exists?
    file_unpacked?
  end

  def file_exists?
    File.file?(file_name)
  end

  def file_unpacked?
    File.file?(unpacked_file_name)
  end

  def unpack
    puts 'Unpacking...'
    command = "gzip -cd #{file_name} > #{unpacked_file_name}"
    puts command
    `#{command}`
  end

  def prepare_data
    unpack unless file_unpacked?
    open(unpacked_file_name).read if file_unpacked?
  end
end
