require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/client')
require('./lib/stylist')
require('pg')
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

get('/') do
  erb(:index)
end

get('/stylists/new') do
  erb(:stylists_form)
end

post('/stylists') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  stylist = Stylist.new(:name => name, :phone => phone, :id => nil)
  stylist.save()
  @stylists = Stylist.all()
  erb(:stylists)
end

get('/stylists') do
  @stylists = Stylist.all()
  erb(:stylists)
end
