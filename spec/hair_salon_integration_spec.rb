require('capybara/rspec')
require('./app')
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a new stylist', {:type => :feature}) do
  it('allows a user to click a stylist and see all their clients and details') do
    visit('/')
    click_link('View All Stylists')
    fill_in('stylist_name', :with => 'Margaret Thatcher')
    fill_in('stylist_phone', :with => '909-808-7070')
    click_button('Add Stylist')
    expect(page).to have_content('Margaret Thatcher')
  end
end

describe('viewing all of the stylists', {:type => :feature}) do
  it('allows a user to see all of the lists that have been created') do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    visit('/')
    click_link('View All Stylists')
    expect(page).to have_content(stylist.name)
  end
end

describe('adding clients to a stylist', {:type => :feature}) do
  it('allows a user to add a client to a stylist') do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    visit('/stylists')
    click_link('John Smith')
    fill_in('stylist_client_name', {:with => 'Mary Jane'})
    fill_in('stylist_client_phone', {:with => '987-789-1011'})
    click_button("Add Client")
    expect(page).to have_content("Mary Jane")
  end
end

describe('view details for a stylist', {:type => :feature}) do
  it('allows user to see the details of a stylist') do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    client = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
    client.save()
    visit('/stylists')
    click_link(stylist.name())
    expect(page).to have_content(client.name())
  end
end

describe('adding a new client', {:type => :feature}) do
  it('allows a user to add a new client') do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    client = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
    client.save()
    visit('/clients')
    fill_in('client_name', {:with => 'Mary Jane'})
    fill_in('client_phone', {:with => '987-789-1011'})
    select('John Smith', {:from => 'stylist_id'})
    click_button("Add Client")
    expect(page).to have_content("Mary Jane")
  end
end

describe('updating a stylist', {:type => :feature}) do
  it 'allows user to edit the stylist' do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    visit('/stylists')
    click_link('John Smith')
    fill_in('new_stylist_name', :with => 'Margaret Thatcher')
    fill_in('new_stylist_phone', :with => '909-808-7070')
    click_button('Update')
    expect(page).to have_content("Margaret Thatcher")
  end
end

describe('deleting a stylist', {:type => :feature}) do
  it 'allows user to delete a stylist' do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    visit('/stylists')
    click_link('John Smith')
    click_button('Delete Stylist')
    expect(page).to have_content("Your Stylists")
  end
end

describe('updating a client', {:type => :feature}) do
  it 'allows user to edit the client' do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    client = Client.new({:name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
    client.save()
    visit('/clients')
    click_link('Mary Jane')
    fill_in('new_client_name', :with => 'Margaret Thatcher')
    fill_in('new_client_phone', :with => '909-808-7070')
    select('John Smith', :from => 'new_stylist_id')
    click_button('Update')
    expect(page).to have_content("Margaret Thatcher")
  end
end

describe('deleting a client', {:type => :feature}) do
  it 'allows user to delete a client' do
    stylist = Stylist.new({:name => "John Smith", :phone =>'312-867-5309', :id => nil})
    stylist.save()
    client = Client.new({:id => nil, :name => "Mary Jane", :phone => "987-789-1011", :stylist_id => stylist.id()})
    client.save()
    visit('/clients')
    click_link('Mary Jane')
    click_button('Delete Client')
    expect(page).to have_content("All Clients")
  end
end
