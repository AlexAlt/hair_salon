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

describe('viewing the details for a specific stylist', {:type => :feature}) do
  it('shows the clients for a specific stylist') do
    stylist = Stylist.new({:name => "River", :id => nil})
    stylist.save()
    client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => stylist.id()})
    client.save()
    visit('/')
    click_link('River')
    expect(page).to have_content("Tyrone")
  end
end

describe('adding a client to a stylist', {:type => :feature}) do
  it('allows a user to add a new client to the stylist page') do
    stylist = Stylist.new({:name => "River", :id => nil})
    stylist.save()
    visit("/stylists/#{stylist.id()}")
    fill_in('name', :with => "Tyrone")
    click_button("Add")
    expect(page).to have_content("Tyrone")
  end
end

describe('viewing a stylist removal form', {:type => :feature}) do
  it('displays page to remove a stylists') do
    stylist = Stylist.new({:name => "River", :id => nil})
    stylist.save()
    visit("/stylists/#{stylist.id()}")
    click_link("Remove this stylist")
    expect(page).to have_content("River")
  end
end

describe('removing a stylist from the record', {:type => :feature}) do
  it('allows a user to remove a stylist') do
    stylist = Stylist.new({:name => "River", :id => nil})
    stylist.save()
    visit("/stylists/#{stylist.id()}/edit")
    click_button("Delete")
    expect(page).to have_content("Salon Management System")
  end
end

describe('updating stylist name', {:type => :feature}) do
  it('allows user to update a stylist name') do
    stylist = Stylist.new({:name => "River", :id => nil})
    stylist.save()
    visit("/stylists/#{stylist.id()}")
    fill_in('new_name', :with => "River Tam")
    click_button("Update")
    expect(page).to have_content("River Tam")
  end
end

describe('removing a client from the record', {:type => :feature}) do
  it('allows a user to remove a client') do
    stylist = Stylist.new({:name => "River", :id => nil})
    stylist.save()
    client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => stylist.id()})
    client.save()
    visit("/client_edit/#{client.id()}")
    click_button("Remove Client")
    expect(page).to have_content("River")
  end
end

describe('updating stylist name', {:type => :feature}) do
  it('allows user to update a stylist name') do
    stylist = Stylist.new({:name => "River", :id => nil})
    stylist.save()
    client = Client.new({:name => "Tyrone", :id => nil, :stylist_id => stylist.id()})
    client.save()
    visit("/client_edit/#{client.id()}")
    fill_in('new_name', :with => "Tyrone Gonzalez")
    click_button("Update")
    expect(page).to have_content("Tyrone Gonzalez")
  end
end
