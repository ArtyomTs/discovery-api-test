class DataStorage
  def initialize(country, data_format='xml')
    @country = country
    @format = data_format
  end

  def read
    load_data unless data_exists?
    prepare_data
  end

  private

  def load_data
    raise NonImplementedError
  end

  def data_exists?
    raise NonImplementedError
  end
end
