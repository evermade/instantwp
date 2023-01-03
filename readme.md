# InstantWP

InstantWP is a Docker based tool to instantly spin up a WordPress site. It's meant for rapid prototyping and testing plugins and themes.

## Requirements

- Docker

## Usage

- Run `./instantwp`
- Open your browser: http://127.0.0.1

## Available parameters

- u: Domain
- p: List of plugins you want to install. Comma separated list.
- l: Locale ([https://make.wordpress.org/polyglots/teams/](https://make.wordpress.org/polyglots/teams/))

Example command with parameters:  
`./instantwp -u localhost -p bbpress,akismet -l fi`

WordPress files are located in public-folder.

## Credentials

WP admin account: instantwp / instantwp

## Cleanup and reinstall

If you want to remove the current WordPress installation and reinstall it you can run:  
`./instantwp clean`

## Good to know

- This tool IS NOT SUITABLE for production use
- If you want to reinstall WordPress just manually empty public or mysql-data -folder.

## Author

Jaakko Alajoki
twitter.com/mrjaamo

## License

GPLv2
