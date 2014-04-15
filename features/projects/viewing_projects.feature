Feature: Viewing projects
  In order to assign tickets to project
  As a user
  I want to the list of projects

  Scenario: Listing projects
    Given there is a project called "Sublime Text 2"
    And I am on the homepage
    When I follow "Sublime Text 2"
    Then I should be on the project page for "Sublime Text 2"