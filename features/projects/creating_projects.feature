Feature: Creating projects
  In order to have projects to assing tickets to
  As a user
  I want to create them
  
  Background:
    Given there are the following users:
      | email             | password | admin |
      | user@ticketee.com | password | true  |
    And I am signed in as them
    Given I am on the homepage
    When I follow "New Project"
    
  Scenario: Creating project
    And I fill in "Name" with "Sublime Text 2"
    And I press "Create Project"
    Then I should see "Project has been created."
    And I should be on the project page for "Sublime Text 2"

  Scenario: Creating project without name
    And I press "Create Project"
    Then I should see "Project has not been created."
    And I should see "Name can't be blank"