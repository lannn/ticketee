Feature: Signing up
  In order to get on the work
  As a user
  I want to sign up new account
    Scenario: Siging up
      Given I am on the homepage
      When I follow "Sign up"
      And I fill in "Email" with "user@ticketee.com"
      And I fill in "Password" with "password"
      And I fill in "Password confirmation" with "password"
      And I press "Sign up"
      Then I should see "You have signed up successfully."