# Succulent::Cli

This CLI scrapes data from https://www.succulentsandsunshine.com and allows users to learn more about succulents. A list of succulents will be displayed by name (scientific name and common name), the user may then choose a succulent which he/she would like more information on. Additional information such as a description of the plant, ideal water conditions and ideal light conditions will be displayed. The user can then choose a different plant, go back to the main menu, or exit.

To watch a demo of the CLI in action you can visit [here](https://www.youtube.com/watch?v=xzdQmlTeiRw).

## Installation

Clone this repository and execute:

    `$ cd succulent-cli`
    `$ bundle`

## Usage

To run the cli got to the project directory and execute:

    `$ bin/succulent-cli`

## Tests

To run the tests:

    `$ rspec`

## Note

At the time this project was published there was a bug in the Fairy Castle Cactus web page causing the values to be scraped to be returned in different elements. For this reason this succulent has been removed from the returned results in the `SucculentCli::Scraper` class. If this is fixed, lines 26-29 of this class should be removed and should be replaced with simply `@scraped_succulents`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/trishogen/succulent-cli. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Succulent::Cli project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/trishogen/succulent-cli/blob/master/CODE_OF_CONDUCT.md).
