Given /^the "([^"]*)" endpoint$/ do |country|
  @endpoint = Marketplace::Endpoint[country]
end

Given /^I send that endpoint a (get|post) to \/(orders) with parameters:$/ do |method, path, table|
  client = Marketplace::Client.new(endpoint: @endpoint)
  @response = client.list_orders(table.rows_hash)
end

Then /^I should get a (\d+) response$/ do |code|
  @response.code.should == code
end
