# InstantWP

InstantWP is a Docker based tool to instantly spin up a WordPress site. It's meant for rapid prototyping and testing plugins and themes.

## Requirements

- Docker

## Usage

- Run `./instantwp -u localhost -p bbpress,akismet`
- Open your browser!

## Available parameters

- u: Domain
- p: List of plugins you want to install. Comma separated list.
- l: Locale ([https://make.wordpress.org/polyglots/teams/](https://make.wordpress.org/polyglots/teams/))

WordPress files are located in public-folder.

## Credentials

WP admin account: instantwp / instantwp

## Good to know

- This tool IS NOT SUITABLE for production use
- If you want to reinstall WordPress just empty public or mysql-data -folder.

## Author

Jaakko Alajoki
twitter.com/mrjaamo

## License

GPLv2
