require 'uri'
require 'cgi'
require 'sinatra'
require_relative '../support/paths'

configure do
	enable :sessions
end

module WithinHelpers
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^I wait for (\d+) seconds?$/ do |secs|
  sleep secs.to_i
end

When /^I log out of twitter$/ do
   begin
       visit 'https://twitter.com/logout' 
       click_button("Log out")
    rescue Capybara::ElementNotFound
        puts "already logged out"
    end
end

When /^I am signed in as admin from sheffield$/ do
   visit '/login' 
   fill_in("Username or email", :with => "ise19team29")
   fill_in("Password", :with => "SoftEng2019")
   click_button("Sign In")
    if page.has_content?("Help us keep your account safe.")
       fill_in("challenge_response", :with => "tbtonner1@sheffield.ac.uk")
       click_button("Submit")
   end
end

When /^I am signed in as admin from manchester$/ do
   visit "/login"
   fill_in("Username or email", :with => "altataxis")
   fill_in("Password", :with => "SoftEng2019")
   click_button("Sign In")
   if page.has_content?("Help us keep your account safe.")
       fill_in("challenge_response", :with => "mmsarpatwar1@sheffield.ac.uk")
       click_button("Submit")
   end
end

When /^(?:|I )press "([^\"]*)"(?: within "([^\"]*)")?$/ do |button, selector|
  with_scope(selector) do
    click_button(button)
  end
end

When /^(?:|I )click "([^\"]*)"(?: within "([^\"]*)")?$/ do |click, selector|
  with_scope(selector) do
    find(click).click
  end
end

When /^(?:|I )click "([^\"]*)" within first element in "([^\"]*)"?$/ do |click, selector|
  with_scope("#{selector} table tbody tr:nth-child(2)") do
    click_link(click)
  end
end

When /^(?:|I )follow "([^\"]*)"(?: within "([^\"]*)")?$/ do |link, selector|
  with_scope(selector) do
    click_link(link)
  end
end

When /^(?:|I )fill in "([^\"]*)" with "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, value, selector|
  with_scope(selector) do
    fill_in(field, :with => value)
  end
end

When /^(?:|I )press "([^\"]*)" within last element in "([^\"]*)"?$/ do |button, selector|
  with_scope("#{selector} table tbody tr:last-child") do
     click_button(button)
  end
end

When /^(?:|I )click on the alert/ do 
  page.driver.browser.switch_to.alert.accept
end

When /^(?:|I )scroll down within "([^\"]*)"/ do |selector|
  page.execute_script "$('#{selector}').scrollTop(10000000000)"
end

When /^(?:|I )tweet to "([^\"]*)"/ do |user|
  TWITTER_CLIENT.update("@ise19team29 this is a test")
end

When /^(?:|I )fill in "([^\"]*)" with randomid(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    fill_in(field, :with => rand.to_s[2..5])
  end
end

When /^(?:|I )fill in "([^\"]*)" with invalid randomid(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    fill_in(field, :with => rand.to_s[2..5])
  end
end

When /^I delete the reply/ do 
  TWITTER_CLIENT.destroy_status("Testing reply to tweets")
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following(?: within "([^\"]*)")?:$/ do |selector, fields|
  with_scope(selector) do
    fields.rows_hash.each do |name, value|
      When %{I fill in "#{name}" with "#{value}"}
    end
  end
end

When /^(?:|I )select "([^\"]*)" from "([^\"]*)"(?: within "([^\"]*)")?$/ do |value, field, selector|
  with_scope(selector) do
    select(value, :from => field)
  end
end

When /^(?:|I )check "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    check(field)
  end
end

When /^(?:|I )uncheck "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    uncheck(field)
  end
end

When /^(?:|I )choose "([^\"]*)"(?: within "([^\"]*)")?$/ do |field, selector|
  with_scope(selector) do
    choose(field)
  end
end

When /^(?:|I )attach the file "([^\"]*)" to "([^\"]*)"(?: within "([^\"]*)")?$/ do |path, field, selector|
  with_scope(selector) do
    attach_file(field, path)
  end
end

Then /^(?:|I )should see JSON:$/ do |expected_json|
  require 'json'
  expected = JSON.pretty_generate(JSON.parse(expected_json))
  actual   = JSON.pretty_generate(JSON.parse(response.body))
  expected.should == actual
end

Then /^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_content(text)
    else
      assert page.has_content?(text)
    end
  end
end

Then /^(?:|I )should see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_xpath('//*', :text => regexp)
    else
      assert page.has_xpath?('//*', :text => regexp)
    end
  end
end

Then /^(?:|I )should not see "([^\"]*)"(?: within "([^\"]*)")?$/ do |text, selector|
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_content(text)
    else
      assert page.has_no_content?(text)
    end
  end
end

Then /^(?:|I )should not see \/([^\/]*)\/(?: within "([^\"]*)")?$/ do |regexp, selector|
  regexp = Regexp.new(regexp)
  with_scope(selector) do
    if page.respond_to? :should
      page.should have_no_xpath('//*', :text => regexp)
    else
      assert page.has_no_xpath?('//*', :text => regexp)
    end
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should
      field_value.should =~ /#{value}/
    else
      assert_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^\"]*)" field(?: within "([^\"]*)")? should not contain "([^\"]*)"$/ do |field, selector, value|
  with_scope(selector) do
    field = find_field(field)
    field_value = (field.tag_name == 'textarea') ? field.text : field.value
    if field_value.respond_to? :should_not
      field_value.should_not =~ /#{value}/
    else
      assert_no_match(/#{value}/, field_value)
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should
      field_checked.should == 'checked'
    else
      assert_equal 'checked', field_checked
    end
  end
end

Then /^the "([^\"]*)" checkbox(?: within "([^\"]*)")? should not be checked$/ do |label, selector|
  with_scope(selector) do
    field_checked = find_field(label)['checked']
    if field_checked.respond_to? :should_not
      field_checked.should_not == 'checked'
    else
      assert_not_equal 'checked', field_checked
    end
  end
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
