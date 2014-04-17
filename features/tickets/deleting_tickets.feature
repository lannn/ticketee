Feature: Deleting Tickets
  In order to remove ticket from a project
  As a user
  I want to delete ticket

  Background:
    Given there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And I am signed in as them
    Given there is a project called "Phu Quoc"
    And "user@ticketee.com" can view the "Phu Quoc" project
    And "user@ticketee.com" can delete tickets in the "Phu Quoc" project
    And "user@ticketee.com" has created ticket for this project:
      | title   |  description   |
      | Backend |  Ruby on Rails |
    Given I am on the homepage
    When I follow "Phu Quoc"
    And I follow "Backend"

  Scenario: Deleting a ticket
    When I follow "Delete Ticket"
    Then I should see "Ticket has been deleted."
    And I should be on the project page for "Phu Quoc"