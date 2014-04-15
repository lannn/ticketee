Feature: Editing projects
  In order to update project information
  As a user
  I want to do this by interface

  Background:
    Given there is a project called "Sublime Text 2"
    And I am on the homepage
    When I follow "Sublime Text 2"
    And I follow "Edit Project"

  Scenario: Updating a project
    And I fill in "Name" with "Sublime Text 3"
    And I press "Update Project"
    Then I should see "Project has been updated."
    And I should be on the project page for "Sublime Text 3"

  Scenario: Updating a project with invalid data
    And I fill in "Name" with ""
    And I press "Update Project"
    Then I should see "Project has not been updated."
