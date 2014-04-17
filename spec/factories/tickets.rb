FactoryGirl.define do
  factory :ticket do
    title "A Ticket"
    description "this is a ticket"
    user
    project
  end
end