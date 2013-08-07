require 'net/http'

class CollectionManagerController < ApplicationController
  def index
    # http://localhost:8888/api/collections
    resp = Net::HTTP.get_response(URI.parse('http://localhost:8888/api/collections'))

    # ==> [{"name":"collection1","instance_dir":"collection1_0"},{"name":"LucidWorksLogs","instance_dir":"LucidWorksLogs"}]
    result = JSON.parse(resp.body)
    
    @collections = result.collect {|c| c['name']}
  end
  
  def set
    session[:collection] = params[:collection]
    redirect_to '/catalog'
  end
end


# base_url = "http://search.yahooapis.com/NewsSearchService/V1/newsSearch?appid=YahooDemo&output=json"
# url = "#{base_url}&query=#{URI.encode(query)}&results=#{results}&start=#{start}"
# resp = Net::HTTP.get_response(URI.parse(url))
# data = resp.body
# 
# # we convert the returned JSON data to native Ruby
# # data structure - a hash
# result = JSON.parse(data)
# 
# # if the hash has 'Error' as a key, we raise an error
# if result.has_key? 'Error'
#    raise "web service error"
# end
