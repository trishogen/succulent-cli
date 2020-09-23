class SucculentCli::Succulent

  attr_accessor :name, :url, :description, :sunlight, :water, :zone

  @@all = []

  def initialize(succulent_hash)
    succulent_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(succulents_array)
    succulents_array.each do |succulent_attributes|
      self.new(succulent_attributes)
    end
  end

  def add_more_succulent_info(succulent_attributes)
    succulent_attributes.each {|key, value| self.send(("#{key}="), value)}
    self
  end

  def add_details
    if self.sunlight.nil?
      more_info = SucculentCli::Scraper.new.scrape_succulent_info(self.url)
      self.add_more_succulent_info(more_info)
    end
  end

  def self.all
    @@all
  end

  def self.find(id)
    self.all[id.to_i-1]
  end
end
