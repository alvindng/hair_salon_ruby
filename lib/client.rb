class Client
attr_reader(:name, :phone, :stylist_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @stylist_id = attributes.fetch(:stylist_id).to_i()
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.stylist_id().==(another_client.stylist_id()))
  end

  define_singleton_method(:all) do
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients")
    returned_clients.each() do |client|
      name = client.fetch('name')
      phone = client.fetch('phone')
      stylist_id = client.fetch('stylist_id').to_i()
      clients.push(Client.new({:name => name, :phone => phone, :stylist_id => stylist_id}))
    end
    clients
  end

  define_method(:save) do
    DB.exec("INSERT INTO clients (name, phone, stylist_id) VALUES ('#{@name}', '#{@phone}', #{@stylist_id});")
  end

end
