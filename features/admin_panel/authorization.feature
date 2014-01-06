Feature: allow access only if user is admin

  Scenario: guest user requests for admin page
    Given I am not signed
    When I access admin_panel
    Then I should be on "login page"

  Scenario: non-admin user requests for admin page
    Given I am signed in as "non_admin" user
    When I access admin_panel
    Then I should be given an explanation as to why I can't access the requested page
    And I should be given a link to go to home page

  Scenario: admin user requests for admin page
    Given I am signed in as "admin" user
    When I access admin_panel
    Then I should be able to access content of requested page

