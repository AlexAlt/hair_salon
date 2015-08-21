require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/stylist')
require('./lib/client')
require('pg')

DB = PG.connect({:dbname => "hair_salon_test"})

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