Feature: Editing User
  In order to change the user's details
  As an admin
  I want to update user

  Background:
    Given there are the following users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as "admin@ticketee.com"

    Given there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    Given I am on the homepage
    And I follow "Admin"
    And I follow "Users"
    And I follow "user@ticketee.com"
    And I follow "Edit User"

  Scenario: Updating a user's details
    When I fill in "Email" with "update_user@ticketee.com"
    And I press "Update User"
    Then I should see "User has been updated."
    And I should see "update_user@ticketee.com"
    And I should not see "user@ticketee.com"

  Scenario: Toggling a user's admin ability
    When I check "Is an admin?"
    And I press "Update User"
    Then I should see "User has been updated."
    And I should see "user@ticketee.com (Admin)"

  Scenario: Updating a user with invalid data
    When I fill in "Email" with "fakefakefake"
    And I press "Update User"
    Then I should see "User has not been updated."
    And I should see "Email is invalid"
