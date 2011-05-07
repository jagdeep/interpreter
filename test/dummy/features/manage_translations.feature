Feature: Manage translations
  In order to manage translations
  As an user
  I want to view, add and edit translations

  Scenario: Add new translation
    Given I am on the new interpreter translation page
    When I fill in "Locale" with "locale 1"
      And I fill in "Key" with "key 1"
      And I fill in "Value" with "value 1"
      And I press "Save"
    Then I should see "Translation added."
      And I should see "locale 1"
      And I should see "key 1"
      And I should see "value 1"

  Scenario: Edit translation
    Given a translation is present with key: hello, value: hello and locale: en
    When I go to the new interpreter translation page
      And I fill in "Key" with "hello"
      And I fill in "Value" with "hello again"
      And I fill in "Locale" with "en"
      And I press "Save"
    Then I should see "hello"
      And I should see "hello again"

  Scenario: Remove translation
    Given a translation is present with key: hello, value: hello and locale: en
    When I go to the interpreter translations page
    Then I should see "Remove" within "#en.hello"
    When I follow "Remove" within "#en.hello"
    Then I should see "Translations removed."
      And I should be on translations page

  Scenario: Search translations
    Given a translation is present with key: hello, value: hello and locale: en
    When I go to the interpreter translations page
      And I fill in "key" with "hello" within "#search_translations"
      And I press "Search"
    Then I should see "hello" within "#translations"
