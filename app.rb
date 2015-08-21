require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/stylist')
require('./lib/client')
require('pg')

DB = PG.connect({:dbname => "hair_salon"})

get('/') do
  @stylists = Stylist.all()
  erb(:index)
end

post('/stylists') do
  name = params.fetch("name")
  new_stylist = Stylist.new({:name => name, :id => nil})
  new_stylist.save()
  @stylists = Stylist.all()
  redirect('/')
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylists)
end

post("/new_client") do
  name = params.fetch("name")
  stylist_id = params.fetch("stylist_id").to_i
  @stylist = Stylist.find(stylist_id)
  new_client = Client.new({:name => name, :id => nil, :stylist_id => stylist_id})
  new_client.save()
  redirect("stylists/#{stylist_id}")
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find(params.fetch("id").to_i)
  erb(:stylist_edit)
end

delete('/stylists/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylist = Stylist.all()
  redirect('/')
end

patch('/update_stylist/:id') do
  name = params.fetch("new_name")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.update({:name => name})
  redirect("stylists/#{@stylist.id()}")
end

get('/client_edit/:id') do
  @client = Client.find(params.fetch("id").to_i())
  erb(:client_edit)
end

delete('/clients/:id') do
  @client = Client.find(params.fetch("id").to_i())
  stylist_id = @client.stylist_id().to_i()
  @client.delete()
  @client = Client.all()
  redirect("stylists/#{stylist_id}")
end

patch('/update_client/:id') do
  name = params.fetch("new_name")
  @client = Client.find(params.fetch("id").to_i())
  @client.update({:name => name})
  redirect("stylists/#{@client.stylist_id()}")
end
