require('spec_helper')

describe('adding a new stylist', {:type => :feature}) do
  it('allows a user to click a stylist and see all their clients and details') do
    visit('/')
    click_link('Add New Stylist')
    fill_in('name', :with => 'Margaret Thatcher')
    fill_in('phone', :with => '909-808-7070')
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
