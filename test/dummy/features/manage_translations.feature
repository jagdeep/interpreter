Feature: Manage translations
  In order to manage translations
  As an user
  I want to view, add and edit translations

  Scenario: Add new translation
    Given I am on the new interpreter translation page
    When I fill in "Key" with "key1"
      And I fill in "En" with "value1"
      And I fill in "Pt" with "value2"
      And I fill in "Es" with "value3"
      And I press "Save"
    Then I should see "Translation added."
      And I should see "value1"
      And I should see "value2"
      And I should see "value3"

  Scenario: Edit translation
    Given a translation is present with key: "hello", en: "hello", pt: "hey" and es: "hoola"
      And I am on the interpreter translations page
    When I follow "Edit" within "#hello"
      And I fill in "En" with "hello again"
      And I fill in "Pt" with "Hey there"
      And I press "Save"
    Then I should see "Translation updated."
      And I should see "hello again"
      And I should see "Hey there"

  Scenario: Remove translation
    Given a translation is present with key: "hello", en: "hello", pt: "hey" and es: "hoola"
    When I go to the interpreter translations page
    Then I should see "hello" within "#translations"
      And I should see "Remove"
    When I follow "Remove"
    Then I should not see "hello" within "#translations"
      And I should see "Translation destroyed."
      And I should be on the interpreter translations page

  Scenario: Search translations
    Given a translation is present with key: "hello", en: "hello", pt: "hey" and es: "hoola"
    When I go to the interpreter translations page
      And I fill in "query" with "hello" within "#search_translations"
      And I press "Search"
    Then I should see "hello" within "#translations"
      And I should see "1 translation found."

  Scenario: View all translations for each key on home page
    Given a translation is present with key: "key1", en: "hello1", pt: "hey1" and es: "hoola1"
      And a translation is present with key: "key2", en: "hello2", pt: "hey2" and es: "hoola2"
    When I go to the interpreter translations page
    Then I should see "hello1" within "#key1"
      And I should see "hey1" within "#key1"
      And I should see "hoola1" within "#key1"
      And I should see "hello2" within "#key2"
      And I should see "hey2" within "#key2"
      And I should see "hoola2" within "#key2"
