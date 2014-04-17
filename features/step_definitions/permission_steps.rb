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