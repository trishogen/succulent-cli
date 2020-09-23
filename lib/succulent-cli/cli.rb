class SucculentCli::CLI

  def initialize(display_size = 20)
    #display_page is the page a user is currenty on
    #display_size is the number of succulents to display per page
    @display_page = 1
    @display_size = display_size
  end

  def call
    welcome
    get_succulents
    list_succulents
    menu
  end

  def welcome
    puts "
          ,*-.                   ,*-.                   ,*-.
          |  |                   |  |                   |  |
      ,.  |  |               ,.  |  |               ,.  |  |
      | |_|  | ,.            | |_|  | ,.            | |_|  | ,.
      `---.  |_| |  WELCOME  `---.  |_| |  WELCOME  `---.  |_| |
          |  .--`                |  .--`                |  .--`
          |  |                   |  |                   |  |
          |  |                   |  |                   |  |
                      ~  Loading succulents ~".green

  end

  def get_succulents
    @scraper = SucculentCli::Scraper.new
    succulents = @scraper.scrape_main_pages
    SucculentCli::Succulent.create_from_collection(succulents)
    @succulents = SucculentCli::Succulent.all
  end

  def list_succulents
    puts "Here is a list of succulents you can learn more about:".yellow
    puts
    puts

    start_index = @display_page * @display_size - @display_size
    stop_index = @display_page * @display_size - 1

    @succulents[start_index..stop_index].each.with_index\
    (start_index + 1) do |succulent, i|
      puts "#{i}. #{succulent.name}"
    end
    puts
  end

  def menu
    input = nil
    while input != "exit"
      puts
      puts
      puts "Enter the number of the succulent you would like more info on, " \
            "type next to go to the next page, type back to go to the " \
            "previous page, type list to see the list of plants again, or " \
            "type exit".yellow
      input = gets.strip.downcase

      if input.to_i > 0 and input.to_i < @succulents.size + 1
        show_more_succulent_info(input)
      elsif input == "list"
        change_page("reset")
      elsif input == "back"
        change_page("decrease")
      elsif input == "next"
        change_page("increase")
      elsif input == "exit"
          goodbye
      else
        puts "Not sure what you mean please try again".yellow
      end

    end
  end

  def change_page(direction)
    @total_pages = @scraper.total_pages
    case direction
    when "increase"
      increase_page
    when "decrease"
      decrease_page
    when "reset"
      @display_page = 1
    end
    list_succulents
  end

  def increase_page
    # if user is on the last page and presses next go to the first page
    @display_page = @display_page == @total_pages ? 1 : @display_page + 1
  end

  def decrease_page
    # if user is on the first page and presses back go to the last page
    @display_page = @display_page == 1 ? @total_pages : @display_page - 1
  end


  def show_more_succulent_info(input)
    the_succulent = SucculentCli::Succulent.find(input)
    the_succulent.add_details
    display_succulent_info(the_succulent)
  end

  def display_succulent_info(succulent)
    puts
    puts succulent.name.green
    puts
    puts succulent.description
    puts
    puts
    puts "Sun requirements: #{succulent.sunlight}"
    puts "Water requirements: #{succulent.water}"
    puts "Zone requirements: #{succulent.zone}"
    puts
    puts "To learn more about me please visit: #{succulent.url}"
  end

  def goodbye
    puts
    puts "
                                                              ,`''',
          Please come back for more information on            ;' ` ;
          succulents! Goodbye!                                ;`,',;
                                                              ;' ` ;
                                                         ,,,  ;`,',;
                                                        ;,` ; ;' ` ;   ,',
                                                        ;`,'; ;`,',;  ;,' ;
                                                        ;',`; ;` ' ; ;`'`';
                                                        ;` '',''` `,',`',;
                                                         `''`'; ', ;`'`'
                                                              ;' `';
                                                              ;` ' ;
                                                              ;' `';
                                                              ;` ' ;
                                                              ; ',';
                                                              ;,' ';".green
  end
end
