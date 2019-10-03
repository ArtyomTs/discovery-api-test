class Statistics

  def initialize
    @counters = {}
  end

  def update_with(row)
    update_grouped_counter_for 'EVENT_STATUS', row['EVENT_STATUS']
    update_grouped_counter_for 'CLASSIFICATION_TYPE', row['CLASSIFICATION_TYPE']
  end

  def to_s
    @counters.keys.map do |key|
      "#{key}: \n" +
      @counters[key].map do |key, val|
        "#{key}: #{val}"
      end.join(' ')
    end.join("\n-----------------------------------\n")
  end

  private

  def update_grouped_counter_for(key, value)
    @counters[key] = {} if @counters[key].nil?
    stats = @counters[key]
    stats[value] ? stats[value] += 1 : stats[value] = 0
  end
end
