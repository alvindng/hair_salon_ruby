require('client')
require('stylist')
require('rspec')
require('pg')
require('capybara/rspec')
require('./app.rb')
require('launchy')
require('pry')

DB = PG.connect({:dbname => 'hair_salon_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM stylists *;")
    DB.exec("DELETE FROM clients *;")
  end
end
