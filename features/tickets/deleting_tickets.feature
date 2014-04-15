Feature: Deleting Tickets
  In order to remove ticket from a project
  As a user
  I want to delete ticket

  Background:
    Given there is a project called "Phu Quoc"
    And project has a ticket:
      | title   |  description   |
      | Backend |  Ruby on Rails |
    Given I am on the homepage
    When I follow "Phu Quoc"
    And I follow "Backend"

  Scenario: Deleting a ticket
    When I follow "Delete Ticket"
    Then I should see "Ticket has been deleted."
    And I should be on the project page for "Phu Quoc"