
require 'uri'
require 'net/http'

class ProjectsController < ApplicationController
  def index
    
   

    url = URI("http://cu.bgfretail.com/event/plusAjax.do")
    
    http = Net::HTTP.new(url.host, url.port)
    
    
    request = Net::HTTP::Post.new(url)
    request["content-type"] = 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'
    request["cache-control"] = 'no-cache'
    request["postman-token"] = '68e0a782-fd75-a5bb-0e2e-2c3285a67032'
    
    @items = []
    @prices = []
    @type = []
    @picture = []
    
    # 가격, 행사타입, 이미지 별 리스트 만들어서 리스트 어펜드하기
    
    (0..15).each do |i| 
      request.body = "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"pageIndex\"\r\n\r\n#{i}\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"listType\"\r\n\r\n1\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"searchCondition\"\r\n\r\n\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"user_id\"\r\n\r\n\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--"
      
      response = http.request(request)
      @result = response.read_body
      
      html_doc = Nokogiri::HTML(@result)
      
      html_doc.css('p.prodName').each do |it|
        @items << it
      end
      
      html_doc.css('p.prodPrice').each do |it|
        @prices << it
      end
      
      html_doc.css('ul').css('li').css('ul').css('li').each do |it|
        @type << it
      end
      
      html_doc.css('ul').css('li').css('div.photo').css('img').each do |it|
        it = it.attribute('src')
        #앞뒤에 img src <> 이거 삭제한다.
        @picture << it
      end
      
    end

  end

  def chow
  end
end
