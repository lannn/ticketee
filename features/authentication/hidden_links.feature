Feature: Hidden links
  In order to clean up the user experiences
  As the system
  I want to hide the links from customers who can't act on them

  Background:
    Given there are the following users:
      | email             | password | admin |
      | user@ticketee.com | password | false |
      | admin@ticketee.com| password | true  |
    And there is a project called "Sublime Text 2"
    And "user@ticketee.com" can view the "Sublime Text 2" project
    And "user@ticketee.com" has created ticket for this project:
      | title   |  description   |
      | Backend |  Ruby on Rails |

  Scenario: New Project link is hidden for the non-signed-in users
    Given I am on the homepage
    Then I should not see the "New Project" link

  Scenario: New Project link is hidden for the signed-in users
    Given I am signed in as "user@ticketee.com"
    Then I should not see the "New Project" link

  Scenario: New Project link is shown for the admin users
    Given I am signed in as "admin@ticketee.com"
    Then I should see the "New Project" link

  Scenario: Edit Project link is hidden for the signed-in users
    Given I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    Then I should not see "Edit Project"

  Scenario: Edit Project link is shown for the admin users
    Given I am signed in as "admin@ticketee.com"
    When I follow "Sublime Text 2"
    Then I should see "Edit Project"

  Scenario: Delete Project link is hidden for the signed-in users
    Given I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    Then I should not see "Delete Project"

  Scenario: Delete Project link is shown for the admin users
   Given I am signed in as "admin@ticketee.com"
   When I follow "Sublime Text 2"
   Then I should see "Delete Project"

  Scenario: New Ticket link is shown to a user with permission
    And "user@ticketee.com" can create tickets on the "Sublime Text 2" project
    And I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    Then I should see the "New Ticket" link

  Scenario: New Ticket link is hidden to users without permission
    And I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    Then I should not see the "New Ticket" link

  Scenario: Admin can see New Ticket link
    Given I am signed in as "admin@ticketee.com"
    When I follow "Sublime Text 2"
    Then I should see the "New Ticket" link
 
 Scenario: Edit Ticket link is shown to a user with permission
    And "user@ticketee.com" can update tickets on the "Sublime Text 2" project
    And I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    And I follow "Backend" 
    Then I should see the "Edit Ticket" link

  Scenario: Edit Ticket link is hidden to users without permission
    And I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    And I follow "Backend" 
    Then I should not see the "Edit Ticket" link

  Scenario: Admin can see Edit Ticket link
    Given I am signed in as "admin@ticketee.com"
    When I follow "Sublime Text 2"
    And I follow "Backend" 
    Then I should see the "Edit Ticket" link

  Scenario: Delete Ticket link is shown to a user with permission
    And "user@ticketee.com" can delete tickets on the "Sublime Text 2" project
    And I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    And I follow "Backend" 
    Then I should see the "Delete Ticket" link

  Scenario: Delete Ticket link is hidden to users without permission
    And I am signed in as "user@ticketee.com"
    When I follow "Sublime Text 2"
    And I follow "Backend" 
    Then I should not see the "Delete Ticket" link

  Scenario: Admin can see Delete Ticket link
    Given I am signed in as "admin@ticketee.com"
    When I follow "Sublime Text 2"
    And I follow "Backend" 
    Then I should see the "Delete Ticket" link
