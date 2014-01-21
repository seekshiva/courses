
When(/^I access admin_panel$/) do
  visit admin_path
end

Then /^I should be on "(.+)"$/ do |page|
  current_path = URI.parse(current_url).path
  path_list = {"login page" => login_path}
  
  current_path.should == path_list[page]
end

Then /^I should be given an explanation as to why I can't access the requested page$/ do
  # Or should we give a 404?
end

Then /^I should be given a link to go to home page$/ do
end

Then /^I should be able to access content of requested page$/ do
end

