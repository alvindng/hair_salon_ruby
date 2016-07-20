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

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end

post('/stylists') do
  name = params.fetch('stylist_name')
  phone = params.fetch('stylist_phone')
  stylist = Stylist.new(:name => name, :phone => phone, :id => nil)
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:stylist)
end

post('/stylists/:id') do
  name = params.fetch('stylist_client_name')
  phone = params.fetch('stylist_client_phone')
  stylist_id = params.fetch('stylist_id').to_i()
  client = Client.new({:id => nil, :name => name, :phone => phone, :stylist_id => stylist_id})
  client.save()
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:stylist)
end

patch("/stylists/:id") do
  name = params.fetch("new_stylist_name")
  phone = params.fetch("new_stylist_phone")
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.update({:name => name, :phone => phone})
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:stylist)
end

delete("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  @stylist.delete()
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:stylists)
end

get('/clients') do
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:clients)
end

post('/clients') do
  name = params.fetch('client_name')
  phone = params.fetch('client_phone')
  stylist_id = params.fetch('stylist_id')
  client = Client.new(:name => name, :phone => phone, :id => nil, :stylist_id => stylist_id)
  client.save()
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:clients)
end

get('/clients/:id') do
  @clients = Client.all()
  @client = Client.find(params.fetch("id").to_i())
  @stylist= Stylist.find(@client.stylist_id())
  @stylists = Stylist.all()
  erb(:client)
end

patch('/clients/:id') do
  @client = Client.find(params.fetch('id').to_i())
  name = params.fetch('new_client_name')
  phone = params.fetch('new_client_phone')
  stylist_id = params.fetch('new_stylist_id')
  @stylist = Stylist.find((stylist_id).to_i())
  @client.update({:name => name, :phone => phone, :stylist_id => stylist_id})
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:client)
end

delete('/clients/:id') do
  @client = Client.find(params.fetch("id").to_i())
  @client.delete()
  @clients = Client.all()
  @stylists = Stylist.all()
  erb(:client)
end
