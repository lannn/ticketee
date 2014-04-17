Feature: Viewing projects
  In order to assign tickets to project
  As a user
  I want to the list of projects

  Background:
    Given there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And I am signed in as "user@ticketee.com"
    And there is a project called "Sublime Text 2"
    And "user@ticketee.com" can view the "Sublime Text 2" project
    And there is a project called "Invisible"

  Scenario: Listing projects
    And I am on the homepage
    Then I should not see "Invisible"
    When I follow "Sublime Text 2"
    Then I should be on the project page for "Sublime Text 2"