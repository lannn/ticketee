Feature: Signing in
  In order to return page and work
  As a user
  I want to sign in manually

  Scenario: Signing in via form
    Given there are the following users:
      | email             | password | unconfirmed  |
      | user@ticketee.com | password | false        |
    And I am signed in as them
