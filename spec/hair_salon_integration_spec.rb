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
