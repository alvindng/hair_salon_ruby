require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:index)
end

get('/stylists/new') do
  erb(:stylists_form)
end

post('/stylists') do
  name = params.fetch('stylist_name')
  phone = params.fetch('stylist_phone')
  stylist = Stylist.new(:name => name, :phone => phone, :id => nil)
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end

post('/stylists/:id') do
  name = params.fetch('client_name')
  phone = params.fetch('client_phone')
  stylist_id = params.fetch('stylist_id').to_i()
  @client = Client.new(:name => name, :phone => phone, :stylist_id => stylist_id)
  @stylist = Stylist.find(stylist_id)
  @client.save()
  @stylists = Stylist.all()
  erb(:stylist)
end

get("/stylists/:id/edit") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist_edit)
end

patch("/stylists/:id") do
  name = params.fetch("name")
  phone = params.fetch("phone")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.update({:name => name, :phone => phone})
  erb(:stylist)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  erb(:index)
end

get('/clients/new') do
  erb(:clients_form)
end

post('/clients') do
  name = params.fetch('client_name')
  phone = params.fetch('client_phone')
  client = Client.new(:name => name, :phone => phone, :id => nil)
  client.save()
  @clients = Client.all()
  erb(:clients)
end

get('/clients') do
  @clients = Client.all()
  erb(:clients)
end

get('/clients/:id') do
  @client = Client.find(params.fetch("id").to_i())
  erb(:client)
end

post('/clients/:id') do
  name = params.fetch('client_name')
  phone = params.fetch('client_phone')
  client_id = params.fetch('client_id').to_i()
  @client = Client.new(:name => name, :phone => phone, :client_id => client_id)
  @client = Client.find(client_id)
  @client.save()
  @clients = Client.all()
  erb(:client)
end

get("/clients/:id/edit") do
  @client = Client.find(params.fetch("id").to_i())
  erb(:client_edit)
end

patch("/clients/:id") do
  name = params.fetch("name")
  phone = params.fetch("phone")
  @client = Client.find(params.fetch("id").to_i())
  @client.update({:name => name, :phone => phone})
  erb(:client)
end

delete("/clients/:id") do
  @client = Client.find(params.fetch("id").to_i())
  @client.delete()
  @clients = Client.all()
  erb(:index)
end
