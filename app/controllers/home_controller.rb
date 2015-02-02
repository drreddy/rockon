class HomeController < ApplicationController
  def index
  	if session['fb_access_token']
  		redirect_to success_url
  	else
  		
  	end
  end

  def success
  	if session['fb_access_token']
        require 'json'
        require 'open-uri'

        #facebook data retreival
        @graph = Koala::Facebook::API.new(session['fb_access_token'])
        @user = @graph.get_object("me")
        @likes = @graph.get_connections(@user["id"], "?fields=music.limit(1000)")

        api_key = "" # api key from music graph
        
        #recommendation data retreival
        base_url = "http://api.musicgraph.com/api/v2/artist/search?api_key=" + api_key + "&similar_to="

        @retreived_data = Array.new()

        @likes['music']['data'].each do |musiclikesdata|
        	search_url = base_url + musiclikesdata['name'].gsub(/\s+/, "+")
            temp = Hash.new()
            temp[:liked] = musiclikesdata['name']
            temp[:recommended] = JSON.parse(open(search_url).read)
        	@retreived_data.push(temp)
        end
        @result = @retreived_data.to_json.html_safe
    else
    	redirect_to root_url
    end
  end

  def test
  end
end
