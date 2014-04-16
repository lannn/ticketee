Given /^project has a ticket:$/ do |table|
  table.hashes.each do |attributes|
    @project.tickets.create!(attributes)
  end
end

Given(/^"(.*?)" has created ticket for this project:$/) do |email, table|
  table.hashes.each do |attributes|
    attributes = attributes.merge!(user: User.find_by_email(email))
    @project.tickets.create!(attributes)
  end
end

Given(/^I am signed in as them$/) do
  steps(%Q{
    Given I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "user@ticketee.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."
  })
end