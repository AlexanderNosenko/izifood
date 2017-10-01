class Tesco	
  require "selenium-webdriver"
  require 'nokogiri'

  def self.delivery_dates_html
	driver = Selenium::WebDriver.for :firefox
	driver.navigate.to "https://ezakupy.tesco.pl/groceries/pl-PL/login"
	
	driver.find_element(:id, "email").send_keys "***REMOVED***"
	driver.find_element(:id, "password").send_keys "***REMOVED***"
	driver.find_element(:css, ".button.button-primary").click	
	
	driver.navigate.to "https://ezakupy.tesco.pl/groceries/pl-PL/slots"
	
	result = 3.times.map do |i|
	  delivery_links = driver.find_elements(:css, '.tabheader.slot-selector--week-tabheader.slot-selector--3-week-tab-space')
	  unless i == 0
		link_url = delivery_links[i].find_element(:css, "a").attribute('href')
		driver.navigate.to link_url
	  end
	  Nokogiri::HTML(driver.page_source).css('.slot-selector').to_html
	end
	# delivery_dates = delivery_links.each_with_index.map do |link, i|
		#  unless i == 0
		# 	link.click 
		# 	wait = Selenium::WebDriver::Wait.new(:timeout => 2)
		# 	wait.until { false&&link.attribute("class").include?('active') }
		# end
	# end

	#Clicking on the Follow link present on the assertselenium home page
	# FollowButton  = driver.find_element(:link, "Follow")
	# FollowButton.click
	 
	# #Typing the Email-Id
	# EmailId = driver.find_element(:id, "user_email")
	# EmailId.send_keys "sampleuser7f7df27@gmail.com"
	 
	 
	#Asserting whether the registration success message is diaplyed
	# SuccessMessage = driver.find_element(:css, "p.message")
	# "Registration complete. Please check your e-mail.".eql? SuccessMessage.text
	# puts "Successfully completed the user registration and validated the Success message"
	 
	#Quitting the browser
	driver.quit
	result.join("\n")
  end
end