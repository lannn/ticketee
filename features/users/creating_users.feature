Feature: Creating Users
  In order to add new users to system
  As an admin
  I want to create new users

  Background:
    Given there are the following users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
    And I am signed in as "admin@ticketee.com"
    Given I am on the homepage
    When I follow "Admin"
    And I follow "Users"
    When I follow "New User"

  Scenario: Creating a new user
    And I fill in "Email" with "new_user@ticketee.com"
    And I fill in "Password" with "password"
    And I press "Create User"
    Then I should see "User has been created."

  Scenario: Leaving email blank results in an error
    When I fill in "Email" with ""
    And I fill in "Password" with "password"
    And I press "Create User"
    Then I should see "User has not been created."
    And I should see "Email can't be blank"

  Scenario: Creating an admin user
    When I fill in "Email" with "new_admin@ticketee.com"
    And I fill in "Password" with "password"
    And I check "Is an admin?"
    And I press "Create User"
    Then I should see "User has been created."
    And I should see "new_admin@ticketee.com (Admin)"