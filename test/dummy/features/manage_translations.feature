Feature: Manage translations
  In order to manage translations
  As an user
  I want to view, add and edit translations

  Scenario: Register new translation
    Given I am on translations page
    When I fill in "Locale" with "locale 1"
      And I fill in "Key" with "key 1"
      And I fill in "Value" with "value 1"
      And I press "Save"
    Then I should see "locale 1"
      And I should see "key 1"
      And I should see "value 1"
