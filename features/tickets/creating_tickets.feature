Feature: Creating tickets
  In order to create tickets for project
  As a user
  I want to select a project and do that

  Background:
    Given there is a project called "Phu Quoc"
    And there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And "user@ticketee.com" can view the "Phu Quoc" project
    And I am signed in as "user@ticketee.com"
    And I am on the homepage
    When I follow "Phu Quoc"
    And I follow "New Ticket"

  Scenario: Create ticket
    When I fill in "Title" with "Backend"
    And I fill in "Description" with "Ruby on Rails"
    And I press "Create Ticket"
    Then I should see "Ticket has been created."
    And I should see "Created by user@ticketee.com"

  Scenario: Creating ticket with invalid attributes
    When I press "Create Ticket"
    Then I should see "Ticket has not been created."
    And I should see "Title can't be blank"
    And I should see "Description can't be blank" 	

  Scenario: Description must be longer than 10 characters
    When I fill in "Title" with "Backend"
    And I fill in "Description" with "less 10"
    And I press "Create Ticket"
    Then I should see "Ticket has not been created."
    And I should see "Description is too short"