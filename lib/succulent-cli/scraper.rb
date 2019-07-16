class SucculentCli::Scraper

  attr_reader :total_pages

  MAIN_PAGE = "https://www.succulentsandsunshine.com/types-of-succulents-plants/page/"

  def initialize(total_pages = 6)
    # set number of pages of succulents, this could possibly change in the future
    @total_pages = total_pages
    @scraped_succulents = []
  end

  def scrape_main_pages
    pages_to_scrape.each do |page|
      succulents = page.css("h2.fusion-post-title a")

      succulents.each do |succulent|
        succulent_main_info = {
          name: succulent.text,
          url: succulent.attribute("href").value
        }
        @scraped_succulents << succulent_main_info
      end
    end

    # The fairy castle cactus page has a bug in it, remove this page for now
    @scraped_succulents.drop_while do |scraped_succulent|
      scraped_succulent[:name] ==  'Acanthocereus tetragonus “Fairy Castle Cactus”'
    end
  end

  def pages_to_scrape
    num_subpages = (1..@total_pages).to_a
    num_subpages.collect do |page_number|
      page_url = MAIN_PAGE + "#{page_number}"
      Nokogiri::HTML(open(page_url))
    end
  end

  def scrape_succulent_info(succulent_url)
    succulent_page = Nokogiri::HTML(open(succulent_url))

    description = succulent_page.css("div.fusion-text p").first.text
    sunlight = succulent_page.css("i.fusion-li-icon.fa-sun.fas").first.\
    parent.parent.css("div.fusion-li-item-content p").text
    location = succulent_page.css("i.fusion-li-icon.fa-home.fas").first.\
    parent.parent.css("div.fusion-li-item-content p").text
    water = succulent_page.css("i.fusion-li-icon.fa-tint.fas").first.\
    parent.parent.css("div.fusion-li-item-content p").text

    succulent_additional_info = {
      description: description,
      sunlight: sunlight,
      location: location,
      water: water
    }
  end
end
