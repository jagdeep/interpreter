Given /^the following translations:$/ do |translations|
  Translation.create!(translations.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) translation$/ do |pos|
  visit translations_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following translations:$/ do |expected_translations_table|
  expected_translations_table.diff!(tableish('table tr', 'td,th'))
end

Given /^a translation is present with key: "([^"]*)", en: "([^"]*)", pt: "([^"]*)" and es: "([^"]*)"$/ do |key, en, pt, es|
  i = InterpreterTranslation.new(:key => key, :en => en, :pt => pt, :es => es)
  i.save
end

