require "minitest/autorun"
require_relative "crawler"

describe Crawler do

  let :bad_request_stub do
    response = Typhoeus::Response.new(code: 418, body: "{'Are you attempting to brew coffee with a teapot?'}")
    Typhoeus.stub(/tf/).and_return(response)
  end

  let :clan_url_stub do
    response = Typhoeus::Response.new(code: 200, body: "{'http://foo.gameme.com/overview/1'}")
    Typhoeus.stub(/tf/).and_return(response)
  end

  let :overview_stub do
    response = Typhoeus::Response.new(code: 200, body: "{'http://foo.gameme.com/playerinfo/12345'}")
    Typhoeus.stub(/overview/).and_return(response)
  end

  let :playerinfo_stub do
    response = Typhoeus::Response.new(code: 200, body: "{'http://steamcommunity.com/profiles/76561198015466913'}")
    Typhoeus.stub(/playerinfo/).and_return(response)
  end

  let :stub_all_the_things do
    clan_url_stub
    overview_stub
    playerinfo_stub
  end

  it "must stop recursion when given a steam profile url" do
    c = Crawler.new "http://steamcommunity.com/profiles/76561198015466913"
    c.go!
    c.steam_ids.must_include "76561198015466913"
  end

  it "must find a steam id from a playerinfo page" do
    playerinfo_stub
    c = Crawler.new "http://foo.gameme.com/playerinfo/12345"
    c.go!
    c.steam_ids.must_include "76561198015466913"
  end

  it "must find a playerinfo url when given an overview url" do
    overview_stub
    playerinfo_stub
    c = Crawler.new "http://foo.gameme.com/overview/1"
    c.go!
    c.steam_ids.must_include "76561198015466913"
  end

  it "must find an overview url when given an clan url" do
    stub_all_the_things
    c = Crawler.new "http://foo.gameme.com/tf"
    c.go!
    c.steam_ids.must_include "76561198015466913"
  end

  it "must catch bad urls and not make requests to them" do
    c = Crawler.new "foo"
    c.go!
    c.errors.must_include "Bad Url: foo"
  end

  it "must handle non-sucessful requests" do
    bad_request_stub
    c = Crawler.new "http://foo.gameme.com/tf"
    c.go!
    c.errors.must_include("{:code=>418, :body=>\"{'Are you attempting to brew coffee with a teapot?'}\"}")
  end

end
