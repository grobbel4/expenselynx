Given /^I have created a new receipt with "([^"]*)" as a participant$/ do |name|
  chuck = User.find_by_email("chuck@example.com")
  Receipt.create!(:user => chuck, :store => Factory(:chipotle), 
                  :total_money => Money.new(33, "USD"),
                  :purchase_date => 1.day.ago,
                  :participants => [Participant.create(:name =>name, :user => chuck)])
end

Then /^I should see the participant "([^"]*)"$/ do |name|
  find(:css, "#receipt_fields_metadata").should have_content name
end

Then /^I should not see the participant "([^"]*)"$/ do |name|
  find(:css, "#receipt_fields_metadata").should_not have_content name
end