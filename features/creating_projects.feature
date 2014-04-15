Feature: Creating projects
  In order to have projects to assing tickets to
  As a user
  I want to create them

  Scenario: Creating project
    Given I am on the homepage
    When I follow "New Project"
    And I fill in "Name" with "Sublime Text 2"
    And I press "Create Project"
    Then I should see "Project has been created."
    And I should be on the project page for "Sublime Text 2"
