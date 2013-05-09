steam_id_fetcher
================
### Idea
Given a url of clan such as "http://xxlgamers.gameme.com/tf":
> 1.) Discover urls of servers. ie "http://xxlgamers.gameme.com/overview/1"

> 2.) For each server url, discover playerinfo urls. ie "http://xxlgamers.gameme.com/playerinfo/345596"

> 3.) For each playerinfo url, discover steam profile urls. ie "http://steamcommunity.com/profiles/76561198015466913"

> 4.) Collect steam id from each discovered steam profile url. ie "76561198015466913"

### Usage
main.rb is a usage example

Tests can be ran with `$ ruby -Itest crawler_test`

This project utilizes [Typhoeus](https://github.com/typhoeus/typhoeus) for fast parallel HTTP requests
