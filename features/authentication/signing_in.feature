Feature: Signing in
  In order to return page and work
  As a user
  I want to sign in manually

  Scenario: Signing in via form
    Given there are the following users
      | email             | password | unconfirmed  |
      | user@ticketee.com | password | false        |
    And I am on the homepage
    When I follow "Sign in"
    And I fill in "Email" with "user@ticketee.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Signed in successfully."
