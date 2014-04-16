Feature: Deleting Users
  In order to remove users from system
  As a admin
  I want to delete users

  Background:
    Given there are the following users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
      | user@ticketee.com  | password | false |
    And I am signed in as "admin@ticketee.com"
    Given I am on the homepage
    And I follow "Admin"
    And I follow "Users"

  Scenario: Deleting Users
    When I follow "user@ticketee.com"
    And I follow "Delete User"
    Then I should see "User has been deleted."

  Scenario: User cannot delete themselves
    When I follow "admin@ticketee.com"
    And I follow "Delete User"
    Then I should see "You cannot delete yourself"