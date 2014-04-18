Feature: Creating comments
  In order to update ticket's progress
  As a user
  I want to leave comments on a ticket

  Background:
    Given there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And I am signed in as "user@ticketee.com"
    And there is a project called "Phu Quoc"
    And "user@ticketee.com" can view the "Phu Quoc" project
    And "user@ticketee.com" has created ticket for this project:
      | title   | description          |
      | Backend | Show the map to user |
    Given I am on the homepage
    And I follow "Phu Quoc"

    Scenario: Creating a comment
      When I follow "Backend"
      And I fill in "Text" with "Added a comment"
      And I press "Create Comment"
      Then I should see "Comment has been created."
      And I should see "Added a comment" within "#comments"

    Scenario: Creating an invalid comment
      When I follow "Backend"
      And I press "Create Comment"
      Then I should see "Comment has not been created."
      And I should see "Text can't be blank"

