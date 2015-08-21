require('spec_helper')
require('./app')
require('capybara/rspec')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adds a stylist to homepage', {:type => :feature}) do
  it('processes user entry and adds a new stylist') do
    visit('/')
    fill_in("name", :with => "River")
    click_button("Add")
    expect(page).to have_content("River")
  end
end