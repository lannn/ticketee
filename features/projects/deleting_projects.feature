Feature: Deleting projects
  In order to remove needless project
  As a user
  I want to delete a project

  Scenario: Deleting a project
    Given there is a project called "Sublime Text 2"
    And I am on the homepage
    When I follow "Sublime Text 2"
    And I follow "Delete Project"
    Then I should see "Project has been deleted."
    And I should not see "Sublime Text 2"