Given /^there is a project called "(.*?)"$/ do |name|
  create(:project, name: "Sublime Text 2")
end