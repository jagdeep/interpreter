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
    Then I should see "hello" within "#translations"
      And I should see "Remove"
    When I follow "Remove"
    Then I should not see "hello" within "#translations"
      And I should see "1 translation destroyed."
      And I should be on the interpreter translations page

  Scenario: Search translations
    Given a translation is present with key: hello, value: hello and locale: en
    When I go to the interpreter translations page
      And I fill in "query" with "hello" within "#search_translations"
      And I press "Search"
    Then I should see "hello" within "#translations"
      And I should see "1 translation found."

  Scenario: View all translations for each key on home page
    Given a translation is present with key: hello, value: hey and locale: en
      And a translation is present with key: hello, value: hoohoo and locale: pt
      And a translation is present with key: hello, value: heehee and locale: es
    When I go to the interpreter translations page
    Then I should see "hey" within "#translations"
      And I should see "hoohoo" within "#translations"
      And I should see "heehee" within "#translations"
