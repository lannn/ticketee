Feature: Viewing tickets
  In order to see the deatail of ticket in project
  As a user
  I want to view ticket from project

  Background:
    Given there are the following users:
      | email             | password |
      | user@ticketee.com | password |
    And I am signed in as them
    Given there is a project called "Phu Quoc"
    And "user@ticketee.com" can view the "Phu Quoc" project
    And "user@ticketee.com" has created ticket for this project:
      | title   |  description   |
      | Backend |  Ruby on Rails |
    Given there is a project called "MOOC"
    And "user@ticketee.com" can view the "MOOC" project
    And "user@ticketee.com" has created ticket for this project:
      | title   |  description       |
      | Mobile  |  iOS, Android, WP8 |
    And I am on the homepage

  Scenario: Viewing tickets for a given project
    When I follow "Phu Quoc"
    Then I should see "Backend"
    And I should not see "Uncreated Project"
    When I follow "Backend"
    Then I should see "Backend" within "#ticket h2"
    And I should see "Ruby on Rails"

    When I follow "Ticketee"
    And I follow "MOOC"
    Then I should see "Mobile"
    And I should not see "Uncreated Project"
    When I follow "Mobile"
    Then I should see "Mobile" within "#ticket h2"
    And I should see "iOS, Android, WP8"

