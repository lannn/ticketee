permission_steps = /^"([^"]*)" can ([^"]*?) ([o|i]n)?\s?the "([^"]*)" project$/

Given permission_steps do |email, permission, on, project|
  create_permission(email, find_project(project), permission)
end

def create_permission(email, object, action)
  Permission.create!(user: User.find_by_email!(email), thing: object, action: action)
end

def find_project(name)
  Project.find_by_name!(name) 
end

When(/^I check "(.*?)" for "(.*?)"$/) do |permission, name|
  project = Project.find_by_name!(name)
  permission = permission.downcase.gsub(" ", "_")
  field_id = "permissions_#{project.id}_#{permission}"
  steps(%Q{When I check "#{field_id}"})
end