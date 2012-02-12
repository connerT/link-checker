require 'rubygems'
require 'watir-webdriver'
require 'net/http'
require 'uri'

b = Watir::Browser.new :firefox, :profile => 'WebDriver'   # This is my custom firefox profile for webdriver
b.driver.manage.timeouts.implicit_wait = 3 #3 seconds
b.goto 'https://www.vitalchek.com/express-birth-certificates.aspx'

mylinks = b.links.collect
puts "Number of links is #{mylinks.size}"

mylinks.each do |link|
  uri = URI.parse link.href
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  puts "#{link.href} is #{response.code}"
  #unless response.code == '200'
    #File.open('error_log.txt','a+'){|file| file.puts "#{link.href} is #{response.code}" } #add a date timestamp
  #end
end

b.close


