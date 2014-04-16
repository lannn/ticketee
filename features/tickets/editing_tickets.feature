Feature: Editing Tickets
  In order to alter ticket information
  As a user
  I want to edit ticket

  Background:
    Given there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And I am signed in as them
    Given there is a project called "Phu Quoc"
    And "user@ticketee.com" has created ticket for this project:
      | title   |  description   |
      | Backend |  Ruby on Rails |
    Given I am on the homepage
    When I follow "Phu Quoc"
    And I follow "Backend"
    And I follow "Edit Ticket"

  Scenario: Updating a ticket
    When I fill in "Title" with "Updated"
    And I press "Update Ticket"
    Then I should see "Ticket has been updated."
    And I should see "Updated" within "#ticket h2"
    And I should not see "Backend"

  Scenario: Updating a ticket with invalid data
    When I fill in "Title" with ""
    And I press "Update Ticket"
    Then I should see "Ticket has not been updated."
