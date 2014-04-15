Given /^there is a project called "(.*?)"$/ do |name|
  create(:project, name: name)
end