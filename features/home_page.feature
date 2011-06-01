Feature: Home Page
	In order to see the curriculum
	As someone interested in learning Ruby
	I want to go to ruby-kickstart.com
	
		Scenario: Viewing the homepage
			When I view the homepage
			Then I should see the heading "Ruby Kickstart"
			And I should see the title "Ruby Kickstart"