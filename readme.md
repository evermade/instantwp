InstantWP
=========

InstantWP is docker based tool to instantly spin up WordPress site. It's meant rapid prototyping and testing plugins and themes.

Requirements
------------

Simple is it :)

* Docker

Usage
-----

* Run `./instantwp -u localhost -p bbpress,akismet`
* Open your browser!

Available parameters
-----

* u: Domain
* p: List of plugins you want to install. Comma separeted list.

WordPress files are located in publis-folder.

Good to know 
------------

* This tool IS NOT SUITABLE for production use
* All data is wiped every time to spin up a new stack

Author
------

Jaakko Alajoki  
twitter.com/jalajoki

Lisence
-------

GPLv2