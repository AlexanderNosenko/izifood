require "selenium-webdriver"
 
#Firefox browser instantiation
driver = Selenium::WebDriver.for :firefox
 
#Loading the assertselenium URL
driver.navigate.to "https://ezakupy.tesco.pl/groceries/pl-PL/login"
 
#Typing the UserName
LoginButton = driver.find_element(:id, "email")
LoginButton.send_keys "***REMOVED***"

LoginButton = driver.find_element(:id, "password")
LoginButton.send_keys "***REMOVED***"

#Clicking on the Submit Button
SubmitButton = driver.find_element(:css, ".button.button-primary")
SubmitButton.click

driver.navigate.to "https://ezakupy.tesco.pl/groceries/pl-PL/slots"

puts driver.find_element(:css, '.slot-selector')#.to_html

#Clicking on the Follow link present on the assertselenium home page
# FollowButton  = driver.find_element(:link, "Follow")
# FollowButton.click
 
# #Typing the Email-Id
# EmailId = driver.find_element(:id, "user_email")
# EmailId.send_keys "sampleuser7f7df27@gmail.com"
 
 
#Asserting whether the registration success message is diaplyed
SuccessMessage = driver.find_element(:css, "p.message")
"Registration complete. Please check your e-mail.".eql? SuccessMessage.text
puts "Successfully completed the user registration and validated the Success message"
 
#Quitting the browser
driver.quit