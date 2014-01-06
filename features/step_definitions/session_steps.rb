
Given /^I am signed in as "(.*?)" user$/ do |user|
  login_as user
end

Given /^I am not signed$/ do
  logout
end
