steam_id_fetcher
================
### Idea
Given a url of clan such as "http://xxlgamers.gameme.com/tf"
> 1.) Discover urls of servers. eg "http://xxlgamers.gameme.com/overview/35"

> 2.) For each server url, discover playerinfo urls. eg "http://xxlgamers.gameme.com/playerinfo/345596"

> 3.) For each playerinfo url, discover steam profile urls. eg "http://steamcommunity.com/profiles/76561198015466913"

> 4.) Collect steam id from each discovered steam profile url. eg "76561198015466913"

### Usage
main.rb is a usage example

Tests can be ran with `$ ruby -Itest crawler_test.rb`

This project utilizes [Typhoeus](https://github.com/typhoeus/typhoeus) for fast parallel HTTP requests
