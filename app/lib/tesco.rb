require "selenium-webdriver"
require 'nokogiri'
require 'headless'

class Tesco	
  BASE_URL = "https://ezakupy.tesco.pl/groceries/en-GB/"
  DRIVER = ENV['SELENIUM_DRIVER']

  def initialize
    raise ArgumentError.new("No selenium driver is set") if DRIVER.blank?
    @headless = Headless.new
    @headless.start
    @driver = Selenium::WebDriver.for DRIVER.to_sym
  end

  def login
    @driver.navigate.to BASE_URL + "login"

    @driver.find_element(:id, "email").send_keys "***REMOVED***"
    @driver.find_element(:id, "password").send_keys "***REMOVED***"
    @driver.find_element(:css, ".button.button-primary").click		
  end

  def delivery_slots_html
    login
    results = get_slots

    #Quitting the browser
    @driver.quit
    @headless.destroy

    results.join("\n")
  end

  def close
    @driver.quit
    @headless.destroy
  end
  
  private


  def get_slots
    @driver.navigate.to BASE_URL + "slots"

    result = 3.times.map do |i|
      delivery_links = @driver.find_elements(:css, '.tabheader.slot-selector--week-tabheader.slot-selector--3-week-tab-space')
      
      unless i == 0
        link_url = delivery_links[i].find_element(:css, "a").attribute('href')
        @driver.navigate.to link_url
      end

      page = Nokogiri::HTML(@driver.page_source).css('.slot-selector').to_html
      page_html = page.gsub(/<(form|a)/, "<div")	  
      page_html.gsub(/<\/(form|a)/, "</div")
    end
  end

end