require 'csv'

class CSVProcessor
  def self.fetch(data, &handler)
    csv = CSV.new data, headers: true

    csv.each do |row|
      handler[row] if block_given?
    end
  end
end
