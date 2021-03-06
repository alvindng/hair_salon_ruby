class Client
attr_reader(:name, :phone, :stylist_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @id = attributes[:id]
    @stylist_id = attributes[:stylist_id]
  end

  define_method(:==) do |another_client|
    self.name().==(another_client.name()).&(self.id().==(another_client.id()))
  end

  define_singleton_method(:all) do
    clients = []
    returned_clients = DB.exec("SELECT * FROM clients;")
    returned_clients.each() do |client|
      name = client.fetch('name')
      phone = client.fetch('phone')
      stylist_id = client.fetch('stylist_id').to_i()
      id = client.fetch('id').to_i()
      clients.push(Client.new({:id => id, :name => name, :phone => phone, :stylist_id => stylist_id}))
    end
    clients
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO clients (name, phone, stylist_id) VALUES ('#{@name}', '#{@phone}', #{@stylist_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_singleton_method(:find) do |id|
    found_client = nil
    Client.all().each() do |client|
      if client.id().==(id)
        found_client = client
      end
    end
    found_client
  end

  define_method(:delete) do
    DB.exec("DELETE FROM clients WHERE id = #{self.id()};")
  end

  define_method(:update) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @id = self.id()
    DB.exec("UPDATE clients SET name = '#{@name}', phone = '#{@phone}', stylist_id = #{@stylist_id} WHERE id = #{@id};")
  end
end
