Feature: Assigning permissions
  In order to restrict to users on projects and tickets
  As an admin
  I want to assign permission to users

  Background: 
    Given there are the following users:
      | email              | password | admin |
      | admin@ticketee.com | password | true  |
      | user@ticketee.com  | password | false |
    And there is a project called "Sublime Text 2"
    And I am signed in as "admin@ticketee.com"
    When I follow "Admin"
    And I follow "Users"
    And I follow "user@ticketee.com"
    And I follow "Permissions"

  Scenario: Viewing a project
    When I check "View" for "Sublime Text 2"
    And I press "Update"
    And I follow "Sign out"

    Given I am signed in as "user@ticketee.com"
    Then I should see "Sublime Text 2"