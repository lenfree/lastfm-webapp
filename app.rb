require 'pry'
require 'sinatra'
require 'httparty'
require 'will_paginate'
require 'will_paginate/array'

include WillPaginate::Sinatra::Helpers

set :views, "views"

helpers do
  def geo_search(country:)
    url = "http://ws.audioscrobbler.com"
    uri_path = "/2.0/?method=geo.gettopartists&country=" + country
    key = "&api_key=#{ENV['API_KEY']}"
    format = '&format=json'
    api_endpoint = url + uri_path + key + format
    HTTParty.get(api_endpoint)
  end

  def artist_search(artist:)
    url="http://ws.audioscrobbler.com"
    uri_path = "/2.0/?method=artist.gettoptracks&artist=" + artist
    key="&api_key=e62a2649a693e94ef3b88b039b9eff55&format=json"
    api_endpoint = url + uri_path + key
    HTTParty.get(api_endpoint)
  end

  def parse_artists(response:)
    response.parsed_response['topartists']['artist']
  end
end

get '/' do
  erb :search_form
end

get '/search' do
  if params[:country_name] == ''
    return 'Parameter missing error'
  end
  @country_name = params[:country_name]
  response = geo_search(country: @country_name)
  @results = parse_artists(response: response).paginate(:page => params[:page], :per_page => 5)
  erb :show
end

post '/search' do
  if params[:country_name] == ''
    return 'Parameter missing error'
  end
  @country_name = params[:country_name]
  response = geo_search(country: @country_name)
  @results = parse_artists(response: response).paginate(:page => params[:page], :per_page => 5)
  erb :show
end

get '/search/artist' do
  if params[:name] == ''
    return 'Parameter missing error'
  end
  response = artist_search(artist: params[:name])
  @top_tracks = response.parsed_response['toptracks']['track']
  erb :show_artist
end
